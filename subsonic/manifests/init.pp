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
  $package_name       = $subsonic::params::subsonic_package_name,
  
  ## Services
  $service_name       = $subsonic::params::subsonic_service_name,
  
  ## Dirs
  $config_dir         = $subsonic::params::subsonic_config_dir,
  $service_dir        = $subsonic::params::subsonic_service_dir,
  $home_dir           = $subsonic::params::subsonic_home,
  
  ## Conf Files
  $config_file        = $subsonic::params::subsonic_config_file,
  $service_file       = $subsonic::params::subsonic_service_file,
  
  ## settings
  $override_settings  = undef,
  $default_settings   = $subsonic::params::subsonic_default_settings,
  
  ## MusicCabinet stuff
  $musiccabinet_zip   = $subsonic::params::subsonic_musiccabinet_zip,
  $install_dir        = $subsonic::params::subsonic_install_dir,
  
) inherits subsonic::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { 'subsonic::install': } ->
  class { 'subsonic::config': } ~>
  class { 'subsonic::service': } ->
  Class['subsonic']
}
