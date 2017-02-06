# == Class audit::params
#
# This class is meant to be called from audit.
# It sets variables according to platform.
#
class audit::params {
  $settings_all  = { 
                    'enable_lynis'        => false,
                    'enable_lynis_cron'   => false 
                   }
  case $::osfamily {
    'Debian': {
      $package_name = 'auditd'
      $service_name = 'auditd'
      $conf_dir     = '/etc/audit'
      $conf_file    = 'auditd.conf'
      $rules_dir    = '/etc/audit/rules.d'
      $rules_file   = 'audit.rules'
      $settings_os  = {}
    }
    'RedHat': {
      $package_name = 'audit'
      $service_name = 'auditd'
      $conf_dir     = '/etc/audit'
      $conf_file    = 'auditd.conf'
      $rules_dir    = '/etc/audit/rules.d'
      $rules_file   = 'audit.rules'
      $settings_os  = {}
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $default_settings = merge($settings_all,$settings_os)
}
