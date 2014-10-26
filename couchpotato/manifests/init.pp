# == Class: couchpotato
#
# Full description of class couchpotato here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class couchpotato (
  ## Service
  $service_name         = $couchpotato::params::cp_service_name,
  
  ### Dir
  $config_dir           = $couchpotato::params::cp_config_dir,
  $service_dir          = $couchpotato::params::cp_service_dir,
  $install_dir          = $couchpotato::params::cp_install_dir,
  
  ## Conf File
  $service_file         = $couchpotato::params::cp_service_file,
  $config_file          = $couchpotato::params::cp_config_file,
  $settings_file        = $couchpotato::params::cp_settings_file,
  
  ## settings
  $override_settings    = undef,
  $default_settings     = $couchpotato::params::cp_default_settings,

) inherits couchpotato::params {
    
  # validate parameters here
  validate_hash($default_settings)
  validate_string($service_name)
  
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)
  
  notify {"end hash looks like this ${settings}":}
  
   ## Get the User's Home Directory
  $var  = "home_${settings['user']}"
  $user_home_dir = inline_template("<%= scope.lookupvar('::$var') %>")
  
  class { 'couchpotato::install': }->
  class { 'couchpotato::config': }~>
  class { 'couchpotato::service': }->
  Class['couchpotato']
}
