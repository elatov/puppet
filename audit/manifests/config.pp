# == Class audit::config
#
# This class is called from audit for service config.
#
class audit::config {
  case $::osfamily {
    'Debian': {
    }
    'RedHat': {
      if ( $::audit::settings['enable_lynis'] == true ){
        file { "${::audit::rules_dir}/${::audit::rules_file}":
          source  => 'puppet:///modules/lynis/audit_rules.conf',
          mode    => '0640'
        }
        if ( $::audit::settings['enable_lynis'] == true ){
	        ensure_packages('crontabs',{ensure => 'present'})
  
          file { "/etc/cron.daily/aureports":
            ensure  => 'present',
            source  => 'puppet:///modules/lynis/audit-reports.sh',
            mode    => '0750',
            require => Package['crontabs'],
            links   => 'follow',
          }
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
