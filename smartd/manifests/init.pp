# == Class: smartd
#
# Full description of class smartd here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class smartd (
  ## Packages
  $package_name	= $smartd::params::smartd_package_name,
  
  ## Services
  $service_name	= $smartd::params::smartd_service_name,
  
  ## Dirs
  $config_dir		= $smartd::params::smartd_config_dir,
  $service_dir	= $smartd::params::smartd_service_dir,
  $home					= $smartd::params::smartd_home,
  
  ## Conf Files
  $config_file	= $smartd::params::smartd_config_file,
  $service_file	= $smartd::params::smartd_service_file,
  
  ## settings
  $settings			= $smartd::params::smartd_settings,
) inherits smartd::params {

  # validate parameters here
  validate_hash($settings)
  validate_string($package_name)

  class { 'smartd::install': } ->
  class { 'smartd::config': } ~>
  class { 'smartd::service': } ->
  Class['smartd']
}
