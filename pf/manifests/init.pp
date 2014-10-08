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
  $service_dir	= $pf::params::pf_service_dir,
  $home					= $pf::params::pf_home,
  
  ## Conf Files
  $config_file		= $pf::params::pf_config_file,
  $rc_conf_file	  = $pf::params::pf_rc_conf_file,
  
  ## settings
  $override_settings      = undef,
  $default_settings      	= $pf::params::default_pf_settings,
) inherits pf::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)

  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($pf::params::default_pf_settings, $override_settings)
  
#  class { 'pf::install': } ->
  class { 'pf::config': } ~>
  class { 'pf::service': } ->
  Class['pf']
}
