# == Class dock_compose::service
#
# This class is meant to be called from dock_compose.
# It ensure the service is running.
#
define dock_compose::run_files (
  $file = $title,
  $docker_compose_home_dir,
  $docker_compose_files_dir
) {

  [$dir, $compose_file] = split($file, '_')
  $result = generate("/usr/bin/grep", "restart", "${$docker_compose_files_dir}/${file}")
  if ($result =~ /always/) {
    docker_compose { "${dir}":
    #docker_compose { "${docker_compose_home_dir}/${dir}/docker-compose.yml":
      compose_files => ["${docker_compose_home_dir}/${dir}/docker-compose.yml"],
      ensure => present,
    }
  }
}
