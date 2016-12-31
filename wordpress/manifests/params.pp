# == Class wordpress::params
#
# This class is meant to be called from wordpress.
# It sets variables according to platform.
#
class wordpress::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'wordpress'
      $service_name = 'wordpress'
    }
    'RedHat', 'Amazon': {
      $package_name = 'wordpress'
      $service_name = 'wordpress'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
