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
  $package_name = $::docker_compose::params::package_name,
  $service_name = $::docker_compose::params::service_name,
) inherits ::docker_compose::params {

  # validate parameters here

  class { '::docker_compose::install': } ->
  class { '::docker_compose::config': } ~>
  class { '::docker_compose::service': } ->
  Class['::docker_compose']
}
