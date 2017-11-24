# Class: dock_compose
# ===========================
#
# Full description of class dock_compose here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class dock_compose (
  $package_name       = $::dock_compose::params::package_name,
  $service_name       = $::dock_compose::params::service_name,
  $default_settings   = $::dock_compose::params::default_settings,
  $override_settings  = undef,
) inherits ::dock_compose::params {

  # validate parameters here
  validate_hash($default_settings)

  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)

  if ($settings['docker_compose_files_list'] == undef){
    if ($settings['docker_compose_files_directory'] != undef) {
      $files = generate("/bin/ls", $::dock_compose::settings["docker_compose_files_directory"])
      $docker_compose_files = split($files, "\n")
    }
  }


  class { '::dock_compose::install': } ->
  class { '::dock_compose::config': } ~>
  # class { '::dock_compose::service': } ->
  Class['::dock_compose']
}
