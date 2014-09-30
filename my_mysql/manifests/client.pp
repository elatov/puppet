# == Class: my_mysql::client
#
# Full description of class my_mysql here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class my_mysql::client (
  ## Packages
  $client_package_name	= $my_mysql::params::my_mysql_client_package_name,
  
  ## Services
  $client_service_name	= $my_mysql::params::my_mysql_client_service_name,
  
  ## Dirs
  $client_config_dir		= $my_mysql::params::my_mysql_client_config_dir,
  $client_service_dir		= $my_mysql::params::my_mysql_client_service_dir,
  $client_home					= $my_mysql::params::my_mysql_client_home,
  
  ## Conf Files
  $client_config_file		= $my_mysql::params::my_mysql_client_config_file,
  $client_service_file	= $my_mysql::params::my_mysql_client_service_file,
  
  ## settings
  $client_settings			= $my_mysql::params::my_mysql_client_settings,
) inherits my_mysql::params {

  # validate parameters here
  validate_hash($client_settings)
  validate_string($client_package_name)

  class { 'my_mysql::client::install': } ->
  class { 'my_mysql::client::config': } ~>
  class { 'my_mysql::client::service': } ->
  Class['my_mysql::client']
}
