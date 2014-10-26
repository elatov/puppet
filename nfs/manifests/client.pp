# == Class: nfs::client
#
# Full description of class nfs here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class nfs::client (
  ## Packages
  $package_name	= $nfs::params::nfs_client_package_name,
  
  ## Services
  $service_name	= $nfs::params::nfs_client_service_name,
  
  ## Dirs
  $config_dir		= $nfs::params::nfs_client_config_dir,
  $service_dir		= $nfs::params::nfs_client_service_dir,
  
  ## Conf Files
  $config_file		= $nfs::params::nfs_client_config_file,
  $service_file	= $nfs::params::nfs_client_service_file,
  
  ## settings
  $default_settings			= $nfs::params::nfs_client_default_settings,
) inherits nfs::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)

  class { 'nfs::client::install': } ->
  class { 'nfs::client::config': } ~>
  class { 'nfs::client::service': } ->
  Class['nfs::client']
}
