# == Class: exim::client
#
# Full description of class exim here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class exim::client (
  ## Packages
  $package_name	          = $exim::params::exim_client_package_name,
  
  ## Services
  $service_name	          = $exim::params::exim_client_service_name,
  
  ## Dirs
  $config_dir		          = $exim::params::exim_client_config_dir,
  $service_dir	          = $exim::params::exim_client_service_dir,
  
  ## Conf Files
  $config_file	          = $exim::params::exim_client_config_file,
  $service_file	          = $exim::params::exim_client_service_file,
  $rc_conf_file           = $exim::params::exim_client_rc_conf_file,
  $periodic_conf_file     = $exim::params::exim_client_periodic_conf_file,
  $mailer_conf_file       = $exim::params::exim_client_maile_conf_file,
  
  ## settings
  $default_settings			  = $exim::params::exim_client_default_settings,
  $override_settings      = undef,
) inherits exim::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($exim::params::exim_client_default_settings, $override_settings)

  class { 'exim::client::install': } ->
  class { 'exim::client::config': } ~>
  class { 'exim::client::service': } ->
  Class['exim::client']
}
