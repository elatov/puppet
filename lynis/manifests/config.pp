# == Class lynis::config
#
# This class is called from lynis for service config.
#
class lynis::config {
  
  case $::osfamily {
    'Debian': {
      $package_name = 'lynis'
      $service_name = 'lynis'
    }
    'RedHat': {
      
      if ( $::lynis::settings['cron_enabled'] == true ){
        ensure_packages('crontabs',{ensure => 'present'})

				file {'/etc/cron.weekly/lynis':
					ensure  => 'present',
					content => template('lynis/lynis-cron.erb'),
					mode    => '0755',
					require => Package['crontabs'],
					links   => 'follow',
				}
      }
      
      if ( $::lynis::settings['tests']['AUTH-9328'] == true ){
        file { "/etc/profile.d/umask.sh":
          source  => 'puppet:///modules/lynis/umask.sh',
          mode    => '0644'
        }
      }
      
      if ( $::lynis::settings['tests']['FILE-6310'] == true ){
        service { 'tmp.mount':
			    ensure     => running,
			    enable     => true,
			    hasstatus  => true,
			  }
      }
      
      if ( $::lynis::settings['tests']['STRG-1840'] == true ){
        file { "/etc/modprobe.d/usb.conf":
          source  => 'puppet:///modules/lynis/modprobe-usb.conf',
          mode    => '0644'
        }
      }
      
      if ( $::lynis::settings['tests']['STRG-1846'] == true ){
        file { "/etc/modprobe.d/firewire.conf":
          source  => 'puppet:///modules/lynis/modprobe-firewire.conf',
          mode    => '0644'
        }
      }
      
      if ( $::lynis::settings['tests']['NETW-3032'] == true ){
        class {'arpwatch': }
      }
      
      if ( $::lynis::settings['tests']['SSH-7408'] == true ){
        $::lynis::settings['tests']['SSH-7408_enabled_tests'].each |$key, $value| {
          #notify{"${value} = ${key}":}
          augeas { "sshd_config-${key}":
					  context => "/files/etc/ssh/sshd_config",
					  changes => [
					    # track which key was used to logged in
					    "set ${key} ${value}",
					  ],
					  notify => Service["sshd"],
					}
#					notify {Service["sshd"]:}
#					notify => Service["sshd"]
        }
        if !empty($::lynis::settings['tests']['SSH-7408_disabled_tests']) {
          $lower_case_disabled_tests = downcase($::lynis::settings['tests']['SSH-7408_disabled_tests'])
          $lower_case_disabled_tests.each |$item| {
						file_line{"skip-test-${item}":
							path => "${::lynis::conf_dir}/${::lynis::conf_file}",
							line => "skip-test=SSH-7408:${item}",
						}
          }
        }
      }
#      notify {"$::osfamily":}
      if ( $::lynis::settings['tests']['BANN-7126'] == true ){
        file { "/etc/issue":
          source  => 'puppet:///modules/lynis/issue.txt',
          mode    => '0644'
        }
        
        file { "/etc/issue.net":
          source  => 'puppet:///modules/lynis/issue.txt',
          mode    => '0644'
        }
        
#        augeas { "sshd_config-banner":
#            context => "/files/etc/ssh/sshd_config",
#            changes => [
#              # track which key was used to logged in
#              "set Banner /etc/issue.net",
#            ],
#            notify => Service["sshd"],
#          }
      }
    }

    default: {
      fail("${::operatingsystem} not supported")
    }  
  }
  
}
