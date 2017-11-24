# == Class dock_compose::service
#
# This class is meant to be called from dock_compose.
# It ensure the service is running.
#
define dock_compose::install_files (
  $file = $title,
) {

  [$dir,$compose_file] = split($file, '_')
  # $dir = $file_parts[0]
  # $compose_file = $file_parts[1]
  file { $dir:
    ensure  => "directory",
    path    => "/data/docker/${dir}"
  } ->
  file { $file:
    ensure  => 'present',
    path  => "/data/docker/${dir}/docker-compose.yml",
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
