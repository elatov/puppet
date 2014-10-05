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
  $package_name	          = $ossec::params::ossec_client_package_name,
  
  ## Services
  $service_name	          = $ossec::params::ossec_client_service_name,
  
  ## Dirs
  $config_dir		          = $ossec::params::ossec_client_config_dir,
  $service_dir		        = $ossec::params::ossec_client_service_dir,
  $client_home					  = $ossec::params::ossec_client_home,
  
  ## Conf Files
  $config_file		        = $ossec::params::ossec_client_config_file,
  $service_file	          = $ossec::params::ossec_client_service_file,
  
  ## settings
  $override_settings      = undef,
  $default_settings       = $ossec::params::ossec_client_default_settings,
) 
inherits ossec::params {

  # validate parameters here
  validate_hash(default_settings)
  validate_string($package_name)

  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($ossec::params::ossec_client_default_settings, $override_settings)
  
  class { 'ossec::client::install': } ->
#  class { 'ossec::client::config': } ~>
#  class { 'ossec::client::service': } ->
  Class['ossec::client']
}
