# == Class: iptables
#
# Full description of class iptables here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class iptables (
  ## Packages
  $package_name	= $iptables::params::iptables_package_name,
  
  ## Services
  $service_name	= $iptables::params::iptables_service_name,
  
  ## Dirs
  $config_dir		= $iptables::params::iptables_config_dir,
  
  ## Conf Files
  $config_file	= $iptables::params::iptables_config_file,
  
  ## settings
  $default_settings			= $iptables::params::iptables_default_settings,
  $override_settings     = undef,
) inherits iptables::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { 'iptables::install': } ->
  class { 'iptables::config': } ~>
  class { 'iptables::service': } ->
  Class['iptables']
}
