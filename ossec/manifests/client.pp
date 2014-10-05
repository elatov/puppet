# == Class: ossec::client
#
# Full description of class ossec here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class ossec::client (
  ## Packages
  $ossec_client_package_name	= $ossec::params::ossec_client_package_name,
  
  ## Services
  $ossec_client_service_name	= $ossec::params::ossec_client_service_name,
  
  ## Dirs
  $ossec_client_config_dir		= $ossec::params::ossec_client_config_dir,
  $ossec_client_service_dir		= $ossec::params::ossec_client_service_dir,
  $ossec_client_home					= $ossec::params::ossec_client_home,
  
  ## Conf Files
  $ossec_client_config_file		= $ossec::params::ossec_client_config_file,
  $ossec_client_service_file	= $ossec::params::ossec_client_service_file,
  
  ## settings
  $ossec_client_settings			= $ossec::params::ossec_client_settings,
) inherits ossec::params {

  # validate parameters here
  validate_hash($ossec_client_settings)
  validate_string($ossec_client_package_name)

  class { 'ossec::client::install': } ->
  class { 'ossec::client::config': } ~>
  class { 'ossec::client::service': } ->
  Class['ossec::client']
}
