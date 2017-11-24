# == Class docker_compose::install
#
# This class is called from docker_compose for install.
#
class docker_compose::install {

  $files = generate ("/bin/ls", "/opt/docker-compose-files/")
  $files_array = split($files,"\n")
  #docker_compose::install_files {
  #  $files_array :
  #}
  #$f = type($files)
  #notify { "Type is ${f}" : }
  $dirs = $files_array.map | $dir| {
    $parts = split($dir,"_")
	$hash = { $parts[0] => $parts[1]  }
    $hash
	#{ split($dir,"_")[0] => split($dir,"_")[1] }
  }
  $dirs.each | $key, $value | {
    notify {"key is ${key}, value is ${value}":}
  }
  #$files_array.each | String $file | {
#	$file_split = split($file,"_")
#	$hash = { "${file_split[0]}" => "${file_split[1]}" }
#    notify {"split is ${file_split[0]} and ${file_split[1]}":}
#  }

}
