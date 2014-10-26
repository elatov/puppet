# == Class: plexms
#
# Full description of class plexms here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class plexms (
  ## Packages
  $package_name	      = $plexms::params::plexms_package_name,
  
  ## Services
  $service_name	      = $plexms::params::plexms_service_name,
  
  ## Dirs
  $config_dir		      = $plexms::params::plexms_config_dir,
  $service_dir		    = $plexms::params::plexms_service_dir,
  $home_dir				    = $plexms::params::plexms_home,
  
  ## Conf Files
  $config_file		    = $plexms::params::plexms_config_file,
  $service_file	      = $plexms::params::plexms_service_file,
  
  ## settings
  $default_settings		= $plexms::params::plexms_default_settings,
  $override_settings   = undef
) inherits plexms::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($plexms_package_name)
  
   if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { 'plexms::install': } ->
  class { 'plexms::config': } ~>
  class { 'plexms::service': } ->
  Class['plexms']
}
