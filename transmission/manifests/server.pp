# See README.md for further information on usage.
class transmission::server(
  # Package
  $package_ensure         = $transmission::server::params::server_package_ensure,
  $package_name           = $transmission::server::params::server_package_name,
  # Service
  $service_ensure         = $transmission::server::params::server_service_ensure,
  $service_name           = $transmission::server::params::server_service_name,
  $service_file           = $transmission::server::params::server_service_file,
  $service_file_ensure    = $transmission::server::params::server_service_file_ensure,
  $service_file_dir       = $transmission::server::params::server_service_dir,
  # Configuration parameters
  # Config Dir
  $config_dir             = $transmission::server::params::server_config_dir,
  $config_dir_ensure      = $transmission::server::params::server_config_dir_ensure,
  # Config File
  $config_file            = $transmission::server::params::server_config_file,
  $config_file_ensure     = $transmission::server::params::server_config_file_ensure,
  # Log Dir
  $log_dir                = $transmission::server::params::server_log_dir,
  $log_dir_ensure         = $transmission::server::params::server_log_dir_ensure,
  # Log File
  $log_file               = $transmission::server::params::server_log_file,
  $log_file_ensure        = $transmission::server::params::server_log_file_ensure,
  # Username
  $username               = $transmission::server::params::server_username,
  $username_ensure        = $transmission::server::params::server_username_ensure,
  
  ## transmission daemon settings
  $transmission_settings  = $transmission::server::params::server_transmission_settings,
  ) inherits transmission::server::params {

  validate_hash ($transmission_settings)
  validate_string ($package_name)
  
  # We declare the classes before containing them.
  class { 'transmission::server::install': } ->
  class { 'transmission::server::config': } ~>
  class { 'transmission::server::service': } ->
  Class ['transmission::server']

}
