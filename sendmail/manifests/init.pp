# == Class: sendmail
#
# Full description of class sendmail here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class sendmail (
  ## Packages
  $package_name	        = $sendmail::params::sendmail_package_name,
  
  ## Services
  $service_name	        = $sendmail::params::sendmail_service_name,
  
  ## Dirs
  $config_dir		        = $sendmail::params::sendmail_config_dir,
  $cf_dir               = $sendmail::params::sendmail_cf_dir,
  
  ## Conf Files
  $config_file	        = $sendmail::params::sendmail_config_file,
  $mc_file	            = $sendmail::params::sendmail_mc_file,
  
  ## settings
  $override_settings    = undef,
  $default_settings			= $sendmail::params::sendmail_default_settings,
) inherits sendmail::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { 'sendmail::install': } ->
  class { 'sendmail::config': } ~>
  class { 'sendmail::service': } ->
  Class['sendmail']
}
