# == Class: nfs::server
#
# Full description of class nfs::server here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class nfs::server (
  ## Packages
  $nfs_server_package_name	= $nfs::params::nfs_server_package_name,
  
  ## Services
  $nfs_server_service_name	= $nfs::params::nfs_server_service_name,
  
  ## Dirs
  $nfs_server_config_dir		= $nfs::params::nfs_server_config_dir,
  $nfs_server_service_dir		= $nfs::params::nfs_server_service_dir,
#  $nfs_server_home					= $nfs::params::nfs_server_home,
  
  ## Conf Files
  $nfs_server_config_file		= $nfs::params::nfs_server_config_file,
  $nfs_server_service_file	= $nfs::params::nfs_server_service_file,
  $nfs_server_exports_file  = $nfs::params::nfs_server_exports_file,
  
  ## settings
  $nfs_server_settings			= $nfs::params::nfs_server_settings,
) inherits nfs::params {

  # validate parameters here
  validate_hash($nfs_server_settings)
  validate_string($nfs_server_package_name)

  class { 'nfs::server::install': } ->
  class { 'nfs::server::config': } ~>
  class { 'nfs::server::service': } ->
  Class['nfs::server']
}
