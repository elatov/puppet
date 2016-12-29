# == Class psacct::config
#
# This class is called from psacct for service config.
#
class psacct::config {
  
  case $::osfamily {
    'Debian': {
    }
    'RedHat': {
        if ( $::psacct::settings['cron_enabled'] == true ){
	        ensure_packages('crontabs',{ensure => 'present'})
	
	        file { "/etc/cron.monthly/psacct":
	          ensure  => 'present',
	          source  => 'puppet:///modules/psacct/psacct-cron.sh',
	          mode    => '0755',
            require => Package['crontabs'],
	          links   => 'follow',
          }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
    
    }
}
