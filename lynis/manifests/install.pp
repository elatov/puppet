# == Class lynis::install
#
# This class is called from lynis for install.
#
class lynis::install {

  package { $::lynis::package_name:
    ensure => present,
  }
}
