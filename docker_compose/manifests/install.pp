# == Class docker_compose::install
#
# This class is called from docker_compose for install.
#
class docker_compose::install {

  package { $::docker_compose::package_name:
    ensure => present,
  }
}
