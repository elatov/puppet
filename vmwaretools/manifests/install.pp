# == Class vmwaretools::install
#
# This class is called from vmwaretools for install.
#
class vmwaretools::install {

  package { $::vmwaretools::package_name:
    ensure => present,
  }
}
