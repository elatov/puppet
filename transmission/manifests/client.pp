# See README.md for further information on usage.
class transmission::client(
  # Package
  $package_ensure         = $transmission::client::params::client_package_ensure,
  $package_name           = $transmission::client::params::client_package_name,
  # Configuration parameters
  # Config Dir
  $config_dir             = $transmission::client::params::client_config_dir,
  $config_dir_ensure      = $transmission::client::params::client_config_dir_ensure,
  # Config File
  $config_file            = $transmission::client::params::client_config_file,
  $config_file_ensure     = $transmission::client::params::client_config_file_ensure,
  # Username
  $username               = $transmission::client::params::client_username,
  $username_ensure        = $transmission::client::params::client_username_ensure,
  
  # password
  $password               = $transmission::client::params::client_password,
  
  ## transmission client settings
  $transmission_settings  = $transmission::client::params::client_transmission_settings,
  ) inherits transmission::client::params {

  validate_hash ($transmission_settings)
  validate_string ($package_name)
  
  # We declare the classes before containing them.
  class { 'transmission::client::install': } ->
  class { 'transmission::client::config': } ->
  Class ['transmission::client']

}
