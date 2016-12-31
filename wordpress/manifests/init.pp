# Class: wordpress
# ===========================
#
# Full description of class wordpress here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class wordpress (
  $doc_root          = $::wordpress::params::doc_root,
  $install_dir       = $::wordpress::params::install_dir,
  $wp_owner          = $::wordpress::params::wp_owner,
  $wp_group          = $::wordpress::params::wp_group,
  $download_url      = $::wordpress::params::download_url,
  $version           = $::wordpress::params::version,
  $default_settings  = $::wordpress::params::default_settings,
  $override_settings = undef,
) inherits ::wordpress::params {

  # validate parameters here
  validate_hash($default_settings)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { '::wordpress::install': } ->
#  class { '::wordpress::config': } ~>
#  class { '::wordpress::service': } ->
  Class['::wordpress']
}
