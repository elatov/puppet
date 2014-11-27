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
  $apache_docroot		= $my_wp::params::apache_docroot,
  $apache_confdir		= $my_wp::params::apache_conf_dir,
  
  ## settings
  $wp_owner         = $my_wp::params::wp_owner,
  $wp_group         = $my_wp::params::wp_group,
  $default_settings	= $my_wp::params::default_settings,
  $override_settings = undef,
) inherits my_wp::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($apache_docroot)
  
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { 'my_wp::install': } ->
  class { 'my_wp::config': } ->
  Class['my_wp']
}
