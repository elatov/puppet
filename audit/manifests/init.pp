# Class: audit
# ===========================
#
# Full description of class audit here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class audit (
  $package_name       = $::audit::params::package_name,
  $service_name       = $::audit::params::service_name,
  $conf_dir           = $::audit::params::conf_dir,
  $conf_file          = $::audit::params::conf_file,
  $rules_dir          = $::audit::params::rules_dir,
  $rules_file         = $::audit::params::rules_file,
  $default_settings   = $::audit::params::default_settings,
  $override_settings  = undef,
) inherits ::audit::params {

  # validate parameters here
  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)
  
#  notify {"Settings look like this ${settings}":}

  class { '::audit::install': } ->
  class { '::audit::config': } ~>
  class { '::audit::service': } ->
  Class['::audit']
}
