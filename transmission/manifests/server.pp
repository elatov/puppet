# See README.md for further information on usage.
class transmission::server(
  ## Package
  $package_name       = $transmission::params::transmission_server_package_name,

  ## Service
  $service_name       = $transmission::params::transmission_server_service_name,
  
  ## Dirs
  $config_dir         = $transmission::params::transmission_server_config_dir,
  $service_dir        = $transmission::params::transmission_server_service_dir,
  $log_dir            = $transmission::params::transmission_server_log_dir,

  # Config File
  $service_file       = $transmission::params::transmission_server_service_file,
  $config_file        = $transmission::params::transmission_server_config_file,
  $log_file           = $transmission::params::transmission_server_log_file,
  
  ## settings
  $override_settings  = undef,
  $default_settings   = $transmission::params::transmission_server_default_settings,
  ) inherits transmission::params {

  validate_hash ($default_settings)
  validate_string ($package_name)
  
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)
  
  class { 'transmission::server::install': } ->
  class { 'transmission::server::config': } ~>
  class { 'transmission::server::service': } ->
  Class ['transmission::server']
}
