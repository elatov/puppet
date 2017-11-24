# == Class docker_compose::service
#
# This class is meant to be called from docker_compose.
# It ensure the service is running.
#
define docker_compose::install_files (
  $file                 = $title,
) {

  $full_file = split($file, '_')
  $dir = $full_file[0]
  $compose_file = $full_file[1]
  file { $dir:
    ensure  => "directory",
    path    => "/data/docker/${dir}"
  } ->
  file { $file:
    ensure  => 'present',
    path  => "/data/docker/${dir}/docker-compose.yml",
    source => "puppet:///modules/docker_compose/${file}",
    require => File[$key]
  }
}
