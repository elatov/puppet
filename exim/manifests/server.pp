# == Class: exim::server
#
# Full description of class exim::server here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class exim::server (
  ## Packages
  $package_name	       = $exim::params::exim_server_package_name,
  
  ## Services
  $service_name	       = $exim::params::exim_server_service_name,
  
  ## Dirs
  $config_dir		       = $exim::params::exim_server_config_dir,
  $template_conf_dir   = $exim::params::exim_server_template_conf_dir,

  
  ## Conf Files
  $config_file		     = $exim::params::exim_server_config_file,
  $passwd_file         = $exim::params::exim_server_passwd_file,
  $template_conf_file  = $exim::params::exim_server_template_conf_file,
  
  ## settings
  $default_settings		 = $exim::params::exim_server_default_settings,
  $initial_setup       = $exim::params::exim_server_initial_setup,
  $override_settings   = undef,
) inherits exim::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
   # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { 'exim::server::install': } ->
  class { 'exim::server::config': } ~>
  class { 'exim::server::service': } ->
  Class['exim::server']
}
