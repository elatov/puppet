# Class: vmwaretools
# ===========================
#
# Full description of class vmwaretools here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class vmwaretools (
  $package_name       = $::vmwaretools::params::package_name,
  $service_name       = $::vmwaretools::params::service_name,
  $default_settings   = $::vmwaretools::params::default_settings,
  $override_settings  = undef,
) inherits ::vmwaretools::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { '::vmwaretools::install': } ->
  class { '::vmwaretools::config': } ~>
  class { '::vmwaretools::service': } ->
  Class['::vmwaretools']
}
