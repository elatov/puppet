# Class: arpwatch
# ===========================
#
# Full description of class arpwatch here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class arpwatch (
  $package_name = $::arpwatch::params::package_name,
  $service_name = $::arpwatch::params::service_name,
  $config_dir   = $::arpwatch::params::config_dir,
  $config_file   = $::arpwatch::params::config_file,
  $default_settings     = $::arpwatch::params::default_settings,
  $override_settings     = undef,
) inherits ::arpwatch::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  class { '::arpwatch::install': } ->
  class { '::arpwatch::config': } ~>
  class { '::arpwatch::service': } ->
  Class['::arpwatch']
}
