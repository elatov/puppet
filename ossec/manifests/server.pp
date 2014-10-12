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
  $package_name	      = $ossec::params::ossec_server_package_name,
  
  ## Services
  $service_name	      = $ossec::params::ossec_server_service_name,
  
  ## Dirs
  $config_dir		      = $ossec::params::ossec_server_config_dir,
  $home					      = $ossec::params::ossec_server_home,
  
  ## Conf Files
  $config_file		    = $ossec::params::ossec_server_config_file,
  
  ## settings
  $default_settings		= $ossec::params::ossec_server_default_settings,
  $override_settings  = undef,
) inherits ossec::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($ossec_server_package_name)
  
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($ossec::params::ossec_server_default_settings, $override_settings)

  class { 'ossec::server::install': } ->
  class { 'ossec::server::config': } ~>
#  class { 'ossec::server::service': } ->
  Class['ossec::server']
}
