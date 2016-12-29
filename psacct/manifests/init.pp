# Class: psacct
# ===========================
#
# Full description of class psacct here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class psacct (
  $package_name       = $::psacct::params::package_name,
  $service_name       = $::psacct::params::service_name,
  $default_settings   = $::psacct::params::default_settings,
  $override_settings  = undef,
) inherits ::psacct::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { '::psacct::install': } ->
  class { '::psacct::config': } ~>
  class { '::psacct::service': } ->
  Class['::psacct']
}
