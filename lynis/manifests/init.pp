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
  $package_name = $::lynis::params::package_name,
  $service_name = $::lynis::params::service_name,
) inherits ::lynis::params {

  # validate parameters here

  class { '::lynis::install': } ->
  class { '::lynis::config': } ~>
  class { '::lynis::service': } ->
  Class['::lynis']
}
