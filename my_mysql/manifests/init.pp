# == Class: my_mysql
#
# Full description of class my_mysql here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class my_mysql (
  ## Packages
#  $package_name	= $my_mysql::params::my_mysql_package_name,
  
  ## Services
#  $service_name	= $my_mysql::params::my_mysql_service_name,
  
  ## Dirs
  $config_dir		= $my_mysql::params::my_mysql_config_dir,
#  $service_dir		= $my_mysql::params::my_mysql_service_dir,
#  $home					= $my_mysql::params::my_mysql_home,
  
  ## Conf Files
  $config_file		= $my_mysql::params::my_mysql_config_file,
#  $service_file	= $my_mysql::params::my_mysql_service_file,
  
  ## settings
  $override_settings      = undef,
  $default_settings			  = $my_mysql::params::my_mysql_settings,
) inherits my_mysql::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($config_dir)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { 'my_mysql::install': } ~>
#  class { 'my_mysql::config': } ~>
#  class { 'my_mysql::service': } ->
  Class['my_mysql']
}
