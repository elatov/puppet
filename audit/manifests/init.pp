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
  $package_name = $::audit::params::package_name,
  $service_name = $::audit::params::service_name,
) inherits ::audit::params {

  # validate parameters here

  class { '::audit::install': } ->
  class { '::audit::config': } ~>
  class { '::audit::service': } ->
  Class['::audit']
}
