# == Class: atomic
#
# Full description of class atomic here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class atomic (
  ## Packages
  $atomic_rpm_name          = $atomic::params::atomic_rpm_name,
  
  ## Services
  #$atomic_service_name	= $atomic::params::atomic_service_name,
  
  ## Dirs
  $atomic_config_dir		    = $atomic::params::atomic_config_dir,
    
  ## Conf Files
  $atomic_config_file		    = $atomic::params::atomic_config_file,
  
  ## settings
  $atomic_settings			    = $atomic::params::atomic_settings,
) inherits atomic::params {

  # validate parameters here
  validate_hash($atomic_settings)
  validate_string($atomic_rpm_name)

  class { 'atomic::install': } ->
  class { 'atomic::config': } ->
#  class { 'atomic::service': } ->
  Class['atomic']
}
