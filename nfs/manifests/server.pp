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
  $package_name	      = $nfs::params::nfs_server_package_name,
  
  ## Services
  $service_name	      = $nfs::params::nfs_server_service_name,
  $service_pre        = $nfs::params::nfs_server_service_pre,
  
  ## Conf Files
  $exports_file       = $nfs::params::nfs_server_exports_file,
  
  ## settings
  $override_settings  = undef,
  $default_settings		= $nfs::params::nfs_server_default_settings,
) inherits nfs::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { 'nfs::server::install': } ->
  class { 'nfs::server::config': } ~>
  class { 'nfs::server::service': } ->
  Class['nfs::server']
}
