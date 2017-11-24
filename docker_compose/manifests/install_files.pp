# == Class docker_compose::service
#
# This class is meant to be called from docker_compose.
# It ensure the service is running.
#
define docker_compose::install_files (
  $key               	= $title,
  $settings_hash			= $exim::client::settings,
  $config_file				= $exim::client::config_file,
) {

  $value = $settings_hash[$key]
}
