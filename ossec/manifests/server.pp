# == Class: ossec::server
#
# Full description of class ossec::server here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class ossec::server (
  ## Packages
  $ossec_server_package_name	= $ossec::params::ossec_server_package_name,
  
  ## Services
  $ossec_server_service_name	= $ossec::params::ossec_server_service_name,
  
  ## Dirs
  $ossec_server_config_dir		= $ossec::params::ossec_server_config_dir,
  $ossec_server_service_dir		= $ossec::params::ossec_server_service_dir,
  $ossec_server_home					= $ossec::params::ossec_server_home,
  
  ## Conf Files
  $ossec_server_config_file		= $ossec::params::ossec_server_config_file,
  $ossec_server_service_file	= $ossec::params::ossec_server_service_file,
  
  ## settings
  $ossec_server_settings			= $ossec::params::ossec_server_settings,
) inherits ossec::params {

  # validate parameters here
  validate_hash($ossec_server_settings)
  validate_string($ossec_server_package_name)

  class { 'ossec::server::install': } ->
  class { 'ossec::server::config': } ~>
  class { 'ossec::server::service': } ->
  Class['ossec::server']
}
