# == Class sophos::params
#
# This class is meant to be called from sophos.
# It sets variables according to platform.
#
class sophos::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'sophos'
      $service_name = 'sophos'
    }
    'RedHat', 'Amazon': {
      $package_name = 'sophos'
      $service_name = 'sophos'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
