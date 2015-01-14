# == Class: smartd
#
# Full description of class smartd here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class smartd (
  ## Packages
  $package_name	      = $smartd::params::smartd_package_name,
  
  ## Services
  $service_name	      = $smartd::params::smartd_service_name,
  
  ## Dirs
  $config_dir		      = $smartd::params::smartd_config_dir,
  $service_dir	      = $smartd::params::smartd_service_dir,
  $manifest_dir	      = $smartd::params::smartd_manifest_dir,
  
  ## Conf Files
  $config_file	      = $smartd::params::smartd_config_file,
  $service_file	      = $smartd::params::smartd_service_file,
  $manifest_file      = $smartd::params::smartd_manifest_file,
  
  ## settings
  $override_settings  = undef,
  $default_settings		= $smartd::params::smartd_default_settings,
) inherits smartd::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)

  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)
  
  class { 'smartd::install': } ->
  class { 'smartd::config': } ~>
  class { 'smartd::service': } ->
  Class['smartd']
}
