# == Class: my_wp
#
# Full description of class my_wp here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class my_wp (
  ## Dirs
  $apache_docroot		= $my_wp::params::my_wp_apache_docroot,
  
  ## Conf Files
#  $config_file		= $my_wp::params::my_wp_config_file,
#  $service_file	= $my_wp::params::my_wp_service_file,
  
  ## settings
  $enable_main_wp   = $my_wp::params::my_wp_enable_main_wp,
  $main_wp_name     = $my_wp::params::my_wp_main_wp_name,
  $main_wp_db_pass  = $my_wp::params::my_wp_main_db_pass,
  
  $enable_cs_wp     = $my_wp::params::my_wp_enable_cs_wp,
  $cs_wp_name       = $my_wp::params::my_wp_cs_wp_name,
  $cs_wp_db_pass    = $my_wp::params::my_wp_cs_db_pass,
  
  $wp_owner         = $my_wp::params::my_wp_wp_owner,
  $wp_group         = $my_wp::params::my_wp_wp_group,
#  $settings			    = $my_wp::params::my_wp_settings,
) inherits my_wp::params {

  # validate parameters here
#  validate_hash($settings)
  validate_string($apache_docroot)

  class { 'my_wp::install': } ->
#  class { 'my_wp::config': } ~>
#  class { 'my_wp::service': } ->
  Class['my_wp']
}
