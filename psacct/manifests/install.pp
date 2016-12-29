# == Class psacct::install
#
# This class is called from psacct for install.
#
class psacct::install {

  package { $::psacct::package_name:
    ensure => present,
  }
}
