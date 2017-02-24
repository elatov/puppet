# Class: lynis
# ===========================
#
# Full description of class lynis here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class lynis (
  $package_name           = $::lynis::params::package_name,
  $service_name           = $::lynis::params::service_name,
  $conf_dir               = $::lynis::params::conf_dir,
  $conf_file              = $::lynis::params::conf_file,
  $default_settings       = $::lynis::params::default_settings,
  $override_settings      = undef,
) inherits ::lynis::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)
  notify {"Settings look like this ${settings}":}

  class { '::lynis::install': } ->
  class { '::lynis::config': } ~>
  class { '::lynis::service': } ->
  Class['::lynis']
}
