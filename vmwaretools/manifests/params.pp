# == Class vmwaretools::params
#
# This class is meant to be called from vmwaretools.
# It sets variables according to platform.
#
class vmwaretools::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'vmwaretools'
      $service_name = 'vmwaretools'
    }
    'RedHat', 'Amazon': {
      $package_name = 'vmwaretools'
      $service_name = 'vmwaretools'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
