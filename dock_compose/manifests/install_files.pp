# == Class dock_compose::service
#
# This class is meant to be called from dock_compose.
# It ensure the service is running.
#
define dock_compose::install_files (
  $file = $title,
  $docker_compose_files_dir
) {

  [$dir,$compose_file] = split($file, '_')
  file { $dir:
    ensure  => "directory",
    path    => "${docker_compose_files_dir}/${dir}"
  } ->
  file { $file:
    ensure  => 'present',
    path  => "${docker_compose_files_dir}/${dir}/docker-compose.yml",
    source => "puppet:///modules/dock_compose/${file}",
    require => File[$dir]
  }
  /* Old Day
  define dock_compose::install_files (
  $key               	= $title,
  $settings_hash
) {

  $value = $settings_hash[$key]

  file { $key:
    ensure  => "directory",
    path    => "/data/docker/${key}"
  } ->
  file { $value:
    ensure  => 'present',
    target  => "/data/docker/${key}/docker-compose.yml",
    source => "puppet:///modules/${::module_name}/${value}",
    require => File[$key]
  }


}*/
}
