# == Class ohmyzsh::params
#
# This class is meant to be called from ohmyzsh.
# It sets variables according to platform.
#
class ohmyzsh::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'ohmyzsh'
      $service_name = 'ohmyzsh'
    }
    'RedHat', 'Amazon': {
      $package_name = 'ohmyzsh'
      $service_name = 'ohmyzsh'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
