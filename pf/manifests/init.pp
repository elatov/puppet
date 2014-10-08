# == Class: pf
#
# Full description of class pf here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class pf (
  ## Packages
  $package_name	= $pf::params::pf_package_name,
  
  ## Services
  $service_name	= $pf::params::pf_service_name,
  
  ## Dirs
  $config_dir		= $pf::params::pf_config_dir,
  $service_dir		= $pf::params::pf_service_dir,
  $home					= $pf::params::pf_home,
  
  ## Conf Files
  $config_file		= $pf::params::pf_config_file,
  $service_file	= $pf::params::pf_service_file,
  
  ## settings
  $settings			= $pf::params::pf_settings,
) inherits pf::params {

  # validate parameters here
  validate_hash($settings)
  validate_string($package_name)

  class { 'pf::install': } ->
  class { 'pf::config': } ~>
  class { 'pf::service': } ->
  Class['pf']
}
