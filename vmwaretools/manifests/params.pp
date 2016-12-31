# == Class vmwaretools::params
#
# This class is meant to be called from vmwaretools.
# It sets variables according to platform.
#
class vmwaretools::params {
  $settings_all  = { 'version'  => '1'}
  case $::osfamily {
    'Debian': {
      $package_name = 'open-vm-tools'
      $service_name = 'open-vm-tools'
      $settings_os  = { 'version'  => '1'}
    }
    'RedHat': {
      $package_name = 'open-vm-tools'
      $service_name = 'vmtoolsd'
      $settings_os  = { 'version'  => '1'}
    }
    'FreeBSD': {
      $package_name = 'open-vm-tools-nox11'
      $service_name = 'vmware-guestd'
      $settings_os  = { 'version'  => '1'}
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $default_settings = merge($settings_all,$settings_os)
}
