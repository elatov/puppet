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
  $settings			= $iptables::params::iptables_settings,
) inherits iptables::params {

  # validate parameters here
  validate_hash($settings)
  validate_string($package_name)

  class { 'iptables::install': } ->
  class { 'iptables::config': } ~>
  class { 'iptables::service': } ->
  Class['iptables']
}
