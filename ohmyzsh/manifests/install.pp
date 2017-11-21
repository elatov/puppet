# == Class ohmyzsh::install
#
# This class is called from ohmyzsh for install.
#
class ohmyzsh::install {

  package { $::ohmyzsh::package_name:
    ensure => present,
  }
}
