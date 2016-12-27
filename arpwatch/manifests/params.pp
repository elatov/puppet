# == Class arpwatch::params
#
# This class is meant to be called from arpwatch.
# It sets variables according to platform.
#
class arpwatch::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'arpwatch'
      $service_name = 'arpwatch'
    }
    'RedHat', 'Amazon': {
      $package_name = 'arpwatch'
      $service_name = 'arpwatch'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
