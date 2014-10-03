# == Class: my_apache
#
# Full description of class my_apache here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class my_apache (
  ## Packages
#  $package_name	= $my_apache::params::my_apache_package_name,
#  
#  ## Services
#  $service_name	= $my_apache::params::my_apache_service_name,
#  
  ## Dirs
  $config_dir		= $my_apache::params::my_apache_config_dir,
#  $service_dir		= $my_apache::params::my_apache_service_dir,
#  $home					= $my_apache::params::my_apache_home,
  
  ## Conf Files
  #$config_file		= $my_apache::params::my_apache_config_file,
#  $service_file	= $my_apache::params::my_apache_service_file,
  
  ## settings
  $settings			= $my_apache::params::my_apache_settings,
) inherits my_apache::params {

  # validate parameters here
  validate_hash($settings)
  validate_string($config_dir)

  class { 'my_apache::install': } ->
  class { 'my_apache::config': } ~>
  #class { 'my_apache::service': } ->
  Class['my_apache']
}
