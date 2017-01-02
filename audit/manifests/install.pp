# == Class audit::install
#
# This class is called from audit for install.
#
class audit::install {

  package { $::audit::package_name:
    ensure => present,
  }
}
