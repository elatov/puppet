# See README.md for further information on usage.
class transmission::client(
  # Package
  $package_name       = $transmission::params::transmission_client_package_name,
  # Config File
  $config_file        = $transmission::params::transmission_client_config_file,
  
  ## transmission client settings
  $override_settings  = undef,
  $default_settings   = $transmission::params::transmission_client_default_settings,
  ) inherits transmission::params {

  validate_hash ($default_settings)
  validate_string ($package_name)
  
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)
  
  ## Get the User's Home Directory
  $var  = "home_${settings['user']}"
  $user_home_dir = inline_template("<%= scope.lookupvar('::$var') %>")
  
  $config_dir    = $user_home_dir
  
  class { 'transmission::client::install': } ->
  class { 'transmission::client::config': } ->
  Class ['transmission::client']
}
