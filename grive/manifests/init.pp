# == Class: grive
#
# Full description of class grive::server here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class grive (
  ## Packages
  $package_name	      = $grive::params::grive_package_name,
  
  ## settings
  $initial_setup      = $grive::params::grive_initial_setup,
  $default_settings   = $grive::params::grive_default_settings,
  $override_settings   = undef,
  
) inherits grive::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)
  
  ## Get the User's Home Directory
  $var  = "home_${settings['user']}"
  $user_home_dir = inline_template("<%= scope.lookupvar('::$var') %>")
  
  class { 'grive::install': } ->
  class { 'grive::config': } ~>
#  class { 'grive::service': } ->
  Class['grive']
}
