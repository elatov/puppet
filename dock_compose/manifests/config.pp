# == Class docker_compose::config
#
# This class is called from docker_compose for service config.
#
class dock_compose::config {
  if ($::dock_compose::settings["docker_compose_files_list"] != undef){
    $::dock_compose::settings["docker_compose_files_list"].each | $file | {
      docker_compose { '/data/docker/${file}/docker-compose.yml':
        ensure => present,
      }
    }
  } elsif ($::dock_compose::docker_compose_files != undef) {
    # $::dock_compose::docker_compose_files.each | $dfile | {
    #   [$dir, $compose_file] = split($dfile, '_')
    #   docker_compose { '/data/docker/${dir}/docker-compose.yml':
    #     ensure => present,
    #   }
    # }
    dock_compose::run_files { $::dock_compose::docker_compose_files :
      docker_compose_home_dir => '/data/docker'
    }
  }
}
