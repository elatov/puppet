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
  $nfs_client_package_name	= $nfs::params::nfs_client_package_name,
  
  ## Services
  $nfs_client_service_name	= $nfs::params::nfs_client_service_name,
  
  ## Dirs
  $nfs_client_config_dir		= $nfs::params::nfs_client_config_dir,
  $nfs_client_service_dir		= $nfs::params::nfs_client_service_dir,
  $nfs_client_home					= $nfs::params::nfs_client_home,
  
  ## Conf Files
  $nfs_client_config_file		= $nfs::params::nfs_client_config_file,
  $nfs_client_service_file	= $nfs::params::nfs_client_service_file,
  
  ## settings
  $nfs_client_settings			= $nfs::params::nfs_client_settings,
) inherits nfs::params {

  # validate parameters here
  validate_hash($nfs_client_settings)
  validate_string($nfs_client_package_name)

  class { 'nfs::client::install': } ->
  class { 'nfs::client::config': } ~>
  class { 'nfs::client::service': } ->
  Class['nfs::client']
}
