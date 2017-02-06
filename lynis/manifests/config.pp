# == Class lynis::config
#
# This class is called from lynis for service config.
#
class lynis::config {
  
  case $::osfamily {
    'Debian': {
      if ( $::lynis::settings['cron_enabled'] == true ){
        ensure_packages('anacron',{ensure => 'present'})

        file {'/etc/cron.weekly/lynis':
          ensure  => 'present',
          content => template('lynis/lynis-cron.erb'),
          mode    => '0755',
          require => Package['anacron'],
          links   => 'follow',
        }
      }
      if ( $::lynis::settings['tests']['BOOT-5122'] == true ){
        file_line {"grub-conf-user":
          path    => "/etc/grub.d/40_custom",
          line    => "set superusers=\"${::lynis::settings['tests']['BOOT-5122_user']}\"",
          notify  => Exec["update-grub"],
        }
        
        file_line {"grub-conf-pw":
          path    => "/etc/grub.d/40_custom",
          line    => "password_pbkdf2 ${::lynis::settings['tests']['BOOT-5122_user']} ${::lynis::settings['tests']['BOOT-5122_pdf12_pw']}",
          notify  => Exec["update-grub"],
        }
        
#        file_line {"grub-conf-export":
#          path    => "/etc/grub.d/40_custom",
#          line    => "export superusers",
#          notify  => Exec["update-grub"],
#        } 
        
        exec { "update-grub2":
          alias       => "update-grub",
          refreshonly => true,
          path        => ['/bin', '/usr/bin', '/usr/sbin', ],
        }
        
	   }
	   if ( $::lynis::settings['tests']['AUTH-9262'] == true ){
        ensure_packages('libpam-cracklib',{ensure => 'present'})
     }
     if !empty($::lynis::settings['disabled_tests']) {
          $::lynis::settings['disabled_tests'].each |$item| {
#            augeas { "${module_name}-conf-${item}":
#	            incl    => "${::lynis::conf_dir}/${::lynis::conf_file}",
#	            context => "/files/${::lynis::conf_dir}/${::lynis::conf_file}",
#	            lens    => "Simplevars.lns",
#	            onlyif  => "get skip-test != '${item}'",
#	            changes => [
#	              "set skip-test ${item}",
#	            ],
#            }
            file_line{"${module_name}-conf-${item}":
              path => "${::lynis::conf_dir}/${::lynis::conf_file}",
              line => "skip-test=${item}",
            }
          }
      }
      if ( $::lynis::settings['tests']['AUTH-9328'] == true ){
        file { "/etc/profile.d/umask.sh":
          source  => 'puppet:///modules/lynis/umask.sh',
          mode    => '0644'
        }
				augeas { "${module_name}-login-defs":
					incl    => "/etc/login.defs",
					context => "/files/etc/login.defs",
					lens    => "Login_defs.lns",
					onlyif  => "get UMASK != 027",
					changes => [
					 "set UMASK 027",
					],
				}
				
				file_line{"${module_name}-initd-rc":
                path  => "/etc/init.d/rc",
                line  => "umask 027",
                match => "umask 02",
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
      if ( $::lynis::settings['tests']['PKGS-7370'] == true ){
        ensure_packages('debsums',{ensure => 'present'})
        if !empty($::lynis::settings['tests']['PKGS-7370_cron']){
          augeas { "debsums-${module_name}":
            incl    => "/etc/default/debsums",
            context => "/files/etc/default/debsums",
            lens    => "Simplevars.lns",
            onlyif  => "get CRON_CHECK != ${::lynis::settings['tests']['PKGS-7370_cron']}",
            changes => [
              # track which key was used to logged in
              "set CRON_CHECK ${::lynis::settings['tests']['PKGS-7370_cron']}",
            ],
          }
        }
     }
     
     if ( $::lynis::settings['tests']['HTTP-6640'] == true ){  
       apache::mod { 'evasive20': 
         package        => 'libapache2-mod-evasive',
         lib            => 'mod_evasive20.so',
         loadfile_name  => "evasive.load",
       }->
       apache::custom_config { 'evasive':
         verify_config  => true,
         content        => template('lynis/mod-evasive-conf.erb'),
         priority       => '10',
       }
      }->
			file { "${::lynis::settings['tests']['HTTP-6640_logdir']}":
				ensure => 'directory',
				owner  => 'www-data',
				group  => 'adm',
#				mode   => '0750',
        notify  => Class['my_apache'],
			}
			if ( $::lynis::settings['tests']['HTTP-6643'] == true ){  
       class { 'apache::mod::security': }
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
      if ( $::lynis::settings['tests']['PHP-2376'] == true ){

				augeas { 'php-allow_url_fopen':
					context => '/files/etc/php5/apache2/php.ini',
					changes => [
					 'set PHP/allow_url_fopen Off',
					]
				}
        
      }
      if ( $::lynis::settings['tests']['BANN-7126'] == true ){
        file { "/etc/issue":
          source  => 'puppet:///modules/lynis/issue.txt',
          mode    => '0644'
        }
        
        file { "/etc/issue.net":
          source  => 'puppet:///modules/lynis/issue.txt',
          mode    => '0644'
        }
      }
      if ( $::lynis::settings['tests']['ACCT-9622'] == true ){
        class {'psacct': 
                override_settings => { 'cron_enabled' => true,}
        }
      }  
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
      if ( $::lynis::settings['tests']['ACCT-9622'] == true ){
        class {'psacct': 
                override_settings => { 'cron_enabled' => true,}
        }
      }
      if ( $::lynis::settings['tests']['ACCT-9630'] == true ){
        class {'audit': 
	        override_settings => {
	                              'enable_lynis' => true, 
	                              'enable_lynis_cron' => true,
	                             }
        }
      }
      
      if ( $::lynis::settings['tests']['HRDN-7230'] == true ){
        class {'sophos':}
      }
      
      if ( $::lynis::settings['tests']['KRNL-6000'] == true ){
        $::lynis::settings['tests']['KRNL-6000_enabled_options'].each |$key, $value| {
          #notify{"${value} = ${key}":}
          augeas { "sysctl-${module_name}-${key}":
            incl    => "/etc/sysctl.d/80-lynis.conf",
            context => "/files/etc/sysctl.d/80-lynis.conf",
            lens    => "Simplevars.lns",
            onlyif  => "get ${key} != '${value}'",
            changes => [
              # track which key was used to logged in
              "set ${key} ${value}",
            ],
            notify => Exec["sysctl-system"],
          }
        }
      }
        if !empty($::lynis::settings['tests']['KRNL-6000_enabled_options']) {
          $::lynis::settings['tests']['KRNL-6000_enabled_options'].each |$item| {
            if "${item}" == "net.ipv4.tcp_timestamps"{
              file_line{"disable-sysctl-${item}":
	              path  => "${::lynis::conf_dir}/${::lynis::conf_file}",
	              line  => "#config-data=sysctl;${item};0;1;Do not use TCP time stamps;-;category:security;",
	              match => "config-data=sysctl;${item};0;1;Do not use TCP time stamps;-;category:security;",
              }
            }
            
          }
        }
        
        if ( $::lynis::settings['tests']['HRDN-7222'] == true ){
	        $::lynis::settings['tests']['HRDN-7222_binaries'].each |$item| {
	          file { "compiler-${module_name}-${item}":
	            path    => "${item}",
	            mode    => '0750'
	          }
	        }
	      }
				exec { "sysctl --system":
					alias       => "sysctl-system",
					refreshonly => true,
					path        => ['/usr/bin', '/usr/sbin',],
				}
    }

    default: {
      fail("${::operatingsystem} not supported")
    }  
  }
  
}
