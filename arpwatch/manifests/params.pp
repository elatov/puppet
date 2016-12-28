# == Class arpwatch::params
#
# This class is meant to be called from arpwatch.
# It sets variables according to platform.
#
class arpwatch::params {
  $settings_all  =  { 'conf' =>  { 'run_as'     =>  'arpwatch',
                                   'email_to'   =>  'root',
                                   'email_from' =>  'root (Arpwatch)',
                                 }
                    }
  case $::osfamily {
    'Debian': {
      $package_name = 'arpwatch'
      $service_name = 'arpwatch'
    }
    'RedHat': {
      $package_name = 'arpwatch'
      $service_name = 'arpwatch'
      $config_dir   = '/etc/sysconfig'
      $config_file  = 'arpwatch'
      $settings_os  = undef
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $default_settings = merge($settings_all,$settings_os)
}
