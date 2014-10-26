# == Class: plexms
#
# Full description of class plexms here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class plexms (
  ## Packages
  $plexms_package_name	= $plexms::params::plexms_package_name,
  $plexms_yum_repo      = $plexms::params::plexms_yum_repo,
  $plexms_apt_source    = $plexms::params::plexms_apt_source,
  $plexms_use_rpm       = $plexms::params::plexms_use_rpm,
  $plexms_rpm_name      = $plexms::params::plexms_rpm_name,
  
  ## Services
  $plexms_service_name	= $plexms::params::plexms_service_name,
  
  ## Dirs
  $plexms_config_dir		= $plexms::params::plexms_config_dir,
  $plexms_service_dir		= $plexms::params::plexms_service_dir,
  $plexms_home					= $plexms::params::plexms_home,
  
  ## Conf Files
  $plexms_config_file		= $plexms::params::plexms_config_file,
  $plexms_service_file	= $plexms::params::plexms_service_file,
  
  ## settings
  $plexms_settings			= $plexms::params::plexms_settings,
) inherits plexms::params {

  # validate parameters here
  validate_hash($plexms_settings)
  validate_string($plexms_package_name)

  class { 'plexms::install': } ->
  class { 'plexms::config': } ~>
  class { 'plexms::service': } ->
  Class['plexms']
  #class { 'plexms::config': }->
  #Class['plexms']
}
