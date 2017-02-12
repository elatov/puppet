# == Class psacct::config
#
# This class is called from psacct for service config.
#
class psacct::config {
  
  case $::osfamily {
    'Debian': {
      if ( $::psacct::settings['cron_enabled'] == true ){
        ensure_packages('anacron',{ensure => 'present'})

        file { "/etc/cron.monthly/psacct":
          ensure  => 'present',
          source  => 'puppet:///modules/psacct/psacct-cron.sh',
          mode    => '0750',
          require => Package['anacron'],
          links   => 'follow',
        }
      }
    }
    'RedHat': {
      if ( $::psacct::settings['cron_enabled'] == true ){
        ensure_packages('crontabs',{ensure => 'present'})

        file { "/etc/cron.monthly/psacct":
          ensure  => 'present',
          source  => 'puppet:///modules/psacct/psacct-cron.sh',
          mode    => '0750',
          require => Package['crontabs'],
          links   => 'follow',
        }
      }
    }
    'FreeBSD': {
      if ( $::psacct::settings['cron_enabled'] == true ){

        file { "/etc/periodic/monthly/400.psacct":
          ensure  => 'present',
          source  => 'puppet:///modules/psacct/psacct-cron.sh',
          mode    => '0750',
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
    
    }
}
