# == Class: atomic
#
# Full description of class atomic here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class atomic (
  ## Packages
  $package_name       = $atomic::params::atomic_package_name,
  
  ## Dirs
  $config_dir		      = $atomic::params::atomic_config_dir,
    
  ## Conf Files
  $config_file		    = $atomic::params::atomic_config_file,
  
  ## settings
  $override_settings  = undef,
  $default_settings   = $atomic::params::atomic_default_settings,
) inherits atomic::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)
  
  ## Get the User's Home Directory
  $var  = "home_${settings['user']}"
  $user_home_dir = inline_template("<%= scope.lookupvar('::$var') %>")

  class { 'atomic::install': } ->
  class { 'atomic::config': } ->
#  class { 'atomic::service': } ->
  Class['atomic']
}
