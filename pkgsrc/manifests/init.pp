# == Class: pkgsrc
#
# Full description of class pkgsrc here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class pkgsrc (
  ## Dirs
  $home					= $pkgsrc::params::pkgsrc_home,
  
  ## settings
  $override_settings      = undef,
  $default_settings			= $pkgsrc::params::pkgsrc_default_settings,
) inherits pkgsrc::params {

  # validate parameters here
  validate_hash($settings)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { 'pkgsrc::install': } ->
#  class { 'pkgsrc::config': } ~>
#  class { 'pkgsrc::service': } ->
  Class['pkgsrc']
}
