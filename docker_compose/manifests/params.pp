# == Class docker_compose::params
#
# This class is meant to be called from docker_compose.
# It sets variables according to platform.
#
class docker_compose::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'docker_compose'
      $service_name = 'docker_compose'
    }
    'RedHat', 'Amazon': {
      $package_name = 'docker_compose'
      $service_name = 'docker_compose'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
