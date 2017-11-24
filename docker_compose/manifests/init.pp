# Class: docker_compose
# ===========================
#
# Full description of class docker_compose here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class docker_compose (
  $package_name       = $::docker_compose::params::package_name,
  $service_name       = $::docker_compose::params::service_name,
  $default_settings   = $::docker_compose::params::default_settings,
  $override_settings  = undef,
) inherits ::docker_compose::params {

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
      $files = generate("/bin/ls", $::docker_compose::settings["docker_compose_files_directory"])
      $files_array = split($files, "\n")
      $my_temp_hash = {
        "docker_compose_files" => $files_array
      }
      $settings = merge($settings,$my_temp_hash)
    }
  }


  class { '::docker_compose::install': } ->
  class { '::docker_compose::config': } ~>
  # class { '::docker_compose::service': } ->
  Class['::docker_compose']
}
