# == Class psacct::params
#
# This class is meant to be called from psacct.
# It sets variables according to platform.
#
class psacct::params {
  $settings_all  =  { 'cron_enabled'  => false,}
  
  case $::osfamily {
    'Debian': {
      $package_name = 'acct'
      $service_name = 'acct'
      $settings_os  = undef
    }
    'RedHat': {
      $package_name = 'psacct'
      $service_name = 'psacct'
      $settings_os  = undef
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $default_settings = merge($settings_all,$settings_os)
}
