# == Class docker_compose::config
#
# This class is called from docker_compose for service config.
#
class docker_compose::config {
  if ($::docker_compose::settings["docker_compose_files_list"] != undef){
    $::docker_compose::settings["docker_compose_files_list"].each | $file | {
      docker_compose { '/data/docker/${file}/docker-compose.yml':
        ensure => present,
      }
    }
  } elsif ($::docker_compose::docker_compose_files != undef) {
    docker_compose::run_files {
      $::docker_compose::docker_compose_files :
    }
  }
}
