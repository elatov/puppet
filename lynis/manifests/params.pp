# == Class lynis::params
#
# This class is meant to be called from lynis.
# It sets variables according to platform.
#
class lynis::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'lynis'
      $service_name = 'lynis'
    }
    'RedHat', 'Amazon': {
      $package_name = 'lynis'
      $service_name = 'lynis'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
