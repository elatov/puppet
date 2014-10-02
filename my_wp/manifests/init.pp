# == Class: my_wp
#
# Full description of class my_wp here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class my_wp (
  ## Packages
  $package_name	= $my_wp::params::my_wp_package_name,
  
  ## Services
  $service_name	= $my_wp::params::my_wp_service_name,
  
  ## Dirs
  $config_dir		= $my_wp::params::my_wp_config_dir,
  $service_dir		= $my_wp::params::my_wp_service_dir,
  $home					= $my_wp::params::my_wp_home,
  
  ## Conf Files
  $config_file		= $my_wp::params::my_wp_config_file,
  $service_file	= $my_wp::params::my_wp_service_file,
  
  ## settings
  $settings			= $my_wp::params::my_wp_settings,
) inherits my_wp::params {

  # validate parameters here
  validate_hash($settings)
  validate_string($package_name)

  class { 'my_wp::install': } ->
  class { 'my_wp::config': } ~>
  class { 'my_wp::service': } ->
  Class['my_wp']
}
