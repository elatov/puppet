# == Class sophos::install
#
# This class is called from sophos for install.
#
class sophos::install {

  package { $::sophos::package_name:
    ensure => present,
  }
}
