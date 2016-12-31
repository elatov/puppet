# == Class wordpress::install
#
# This class is called from wordpress for install.
#
class wordpress::install {

  package { $::wordpress::package_name:
    ensure => present,
  }
}
