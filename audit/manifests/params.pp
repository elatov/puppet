# == Class audit::params
#
# This class is meant to be called from audit.
# It sets variables according to platform.
#
class audit::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'audit'
      $service_name = 'audit'
    }
    'RedHat', 'Amazon': {
      $package_name = 'audit'
      $service_name = 'audit'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
