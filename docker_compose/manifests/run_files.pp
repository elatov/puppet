# == Class docker_compose::service
#
# This class is meant to be called from docker_compose.
# It ensure the service is running.
#
define docker_compose::run_files (
  $file = $title,
) {

  [$dir,$compose_file] = split($file, '_')
  docker_compose { '/data/docker/${dir}/docker-compose.yml':
    ensure  => present,
  }
}
