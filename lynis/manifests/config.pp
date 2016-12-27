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
    }
    default: {
      fail("${::operatingsystem} not supported")
    }  
  }
  
}
