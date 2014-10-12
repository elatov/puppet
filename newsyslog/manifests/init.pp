# == Class: newsyslog
#
# Full description of class newsyslog here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class newsyslog (
  ## Packages
  $package_name	= $newsyslog::params::newsyslog_package_name,
  
  ## Services
  $service_name	= $newsyslog::params::newsyslog_service_name,
  
  ## Dirs
  $config_dir		= $newsyslog::params::newsyslog_config_dir,
  $service_dir		= $newsyslog::params::newsyslog_service_dir,
  $home					= $newsyslog::params::newsyslog_home,
  
  ## Conf Files
  $config_file		= $newsyslog::params::newsyslog_config_file,
  $service_file	= $newsyslog::params::newsyslog_service_file,
  
  ## settings
  $settings			= $newsyslog::params::newsyslog_settings,
) inherits newsyslog::params {

  # validate parameters here
  validate_hash($settings)
  validate_string($package_name)

  class { 'newsyslog::install': } ->
  class { 'newsyslog::config': } ~>
  class { 'newsyslog::service': } ->
  Class['newsyslog']
}
