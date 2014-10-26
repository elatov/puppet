# == Class: subsonic
#
# Full description of class subsonic here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class subsonic (
  ## Packages
  $subsonic_package_name  = $subsonic::params::subsonic_package_name,
  $java_jdk_package_name  = $subsonic::params::java_jdk_package_name,
  $unzip_package_name     = $subsonic::params::unzip_package_name,
  $subsonic_rpm           = $subsonic::params::subsonic_rpm,
  
  ## Services
  $subsonic_service_name  = $subsonic::params::subsonic_service_name,
  
  ## Dirs
  $subsonic_config_dir    = $subsonic::params::subsonic_config_dir,
  $subsonic_service_dir   = $subsonic::params::subsonic_service_dir,
  $subsonic_home          = $subsonic::params::subsonic_home,
  
  ## Conf Files
  $subsonic_config_file   = $subsonic::params::subsonic_config_file,
  $subsonic_service_file  = $subsonic::params::subsonic_service_file,
  
  ## settings
  $subsonic_settings      = $subsonic::params::subsonic_settings,
  
  ## MusicCabinet stuff
  $enable_musiccabinet    = $subsonic::params::enable_musiccabinet,
  $musiccabinet_zip       = $subsonic::params::musiccabinet_zip,
  $subsonic_install_dir   = $subsonic::params::subsonic_install_dir,
  $postgres_password      = $subsonic::params::postgres_password,
  
) inherits subsonic::params {

  # validate parameters here
  validate_hash($subsonic_settings)
  validate_string($subsonic_package_name)
  validate_bool($enable_musiccabinet)

  class { 'subsonic::install': } ->
  class { 'subsonic::config': } ~>
  class { 'subsonic::service': } ->
  Class['subsonic']
}
