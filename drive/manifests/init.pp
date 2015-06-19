# == Class: drive
#
# Full description of class drive::server here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class drive (
  ## Packages
  $package_name	      = $drive::params::drive_package_name,
  
  ## settings
  $initial_setup      = $drive::params::drive_initial_setup,
  $default_settings   = $drive::params::drive_default_settings,
  $override_settings   = undef,
  
) inherits drive::params {

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
  
  class { 'drive::install': } ->
  class { 'drive::config': } ~>
#  class { 'grive::service': } ->
  Class['drive']
}
