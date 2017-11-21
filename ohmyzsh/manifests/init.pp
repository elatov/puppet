# Class: ohmyzsh
# ===========================
#
# Full description of class ohmyzsh here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class ohmyzsh (
  ## settings
  $default_settings   = $::ohmyzsh::params::default_settings,
  $override_settings   = undef,
) inherits ::ohmyzsh::params {

  # validate parameters here
  validate_hash($default_settings)

  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  ## Get the User's Home Directory
  $var  = "home_${settings['user']}"
  $user_home_dir = inline_template("<%= scope.lookupvar('::$var') %>")

  class { '::ohmyzsh::install': } ->
  class { '::ohmyzsh::config': } ~>
  # class { '::ohmyzsh::service': } ->
  Class['::ohmyzsh']
}
