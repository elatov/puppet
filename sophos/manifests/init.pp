# Class: sophos
# ===========================
#
# Full description of class sophos here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class sophos (
  $package_name       = $::sophos::params::package_name,
  $service_name       = $::sophos::params::service_name,
  $install_dir        = $::sophos::params::install_dir,
  $initial_setup      = $::sophos::params::initial_setup,
  $setup_dir          = $::sophos::params::setup_dir,
  $version            = $::sophos::params::version,
  $default_settings   = $::sophos::params::default_settings,
  $override_settings  = undef,
) inherits ::sophos::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { '::sophos::install': } ->
  class { '::sophos::config': } ~>
  class { '::sophos::service': } ->
  Class['::sophos']
}
