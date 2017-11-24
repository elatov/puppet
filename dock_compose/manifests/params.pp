# == Class dock_compose::params
#
# This class is meant to be called from dock_compose.
# It sets variables according to platform.
#
class dock_compose::params {
  $settings_all = {
    "docker_compose_files_directory"  => "/opt/docker-compose-files/",
    "docker_compose_files_list" => undef
  }
  case $::osfamily {
    'Debian': {
      $package_name = 'docker_compose'
      $service_name = 'docker_compose'
      $settings_os = {}
    }
    'RedHat', 'Amazon': {
      $package_name = 'docker_compose'
      $service_name = 'docker_compose'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $default_settings = merge($settings_all,$settings_os)
}
