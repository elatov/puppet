# == Class arpwatch::install
#
# This class is called from arpwatch for install.
#
class arpwatch::install {

  package { $::arpwatch::package_name:
    ensure => present,
  }
}
