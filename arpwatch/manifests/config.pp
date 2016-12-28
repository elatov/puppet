# == Class arpwatch::config
#
# This class is called from arpwatch for service config.
#
class arpwatch::config {
  case $::osfamily {
    'Debian': {
      $package_name = 'arpwatch'
      $service_name = 'arpwatch'
    }
    'RedHat': {
      file { '$arpwatch::config_dir/$arpwatch::config_file':
          ensure  => 'present',
          content => template('arpwatch/arpwatch-sysconf.erb'),
          mode    => '0644',
        }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
