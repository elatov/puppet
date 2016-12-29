# == Class psacct::params
#
# This class is meant to be called from psacct.
# It sets variables according to platform.
#
class psacct::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'psacct'
      $service_name = 'psacct'
    }
    'RedHat', 'Amazon': {
      $package_name = 'psacct'
      $service_name = 'psacct'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
