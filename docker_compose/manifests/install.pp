# == Class docker_compose::install
#
# This class is called from docker_compose for install.
#
class docker_compose::install {

  if ($::docker_compose::settings["docker_compose_files_list"] != undef){
    $::docker_compose::settings["docker_compose_files_list"].each | $file | {
      file { $file:
        ensure  => "directory",
        path    => "/data/docker/${file}"
      } ->
      file { $file:
        ensure  => 'present',
        path  => "/data/docker/${file}/docker-compose.yml",
        source => "puppet:///modules/docker_compose/${file}_docker-compose.yml",
        require => File[$file]
      }
    }
  } elsif ($::docker_compose::settings["docker_compose_files"] != undef) {
    docker_compose::install_files {
      $::docker_compose::settings["docker_compose_files"] :
    }
  }


  /* Messing around with hashes and map function
  $f = type($files)
  notify { "Type is ${f}" : }
  $dirs = $files_array.map | $dir| {
    $parts = split($dir,"_")
    $hash = { $parts[0] => $parts[1]  }
    $hash
    { split($dir,"_")[0] => split($dir,"_")[1] }
  }

  $dirs.each | $key, $value | {
  notify {"key is ${key}, value is ${value}":}
  }

  $files_array.each | String $file | {
  $file_split = split($file,"_")
    $hash = { "${file_split[0]}" => "${file_split[1]}" }
    notify {"split is ${file_split[0]} and ${file_split[1]}":}
  } */

}
