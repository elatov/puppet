# == Class lynis::params
#
# This class is meant to be called from lynis.
# It sets variables according to platform.
#
class lynis::params {
  $settings_all  =  { 'cron_enabled'  => true,
                      'cron_email_to' => "root",
                      'tests'         =>  { 'AUTH-9328' => true}
                    }
  case $::osfamily {
    'Debian': {
      $package_name = 'lynis'
      $service_name = 'lynis'
    }
    'RedHat': {
      $settings_os  = {'yum_repo_enabled' =>  true}
      $package_name = 'lynis'
      $service_name = 'lynis'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }  
  }
  $default_settings = merge($settings_all,$settings_os)
}
