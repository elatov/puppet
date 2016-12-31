# Class: wordpress
# ===========================
#
# Full description of class wordpress here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class wordpress (
  $package_name = $::wordpress::params::package_name,
  $service_name = $::wordpress::params::service_name,
) inherits ::wordpress::params {

  # validate parameters here

  class { '::wordpress::install': } ->
  class { '::wordpress::config': } ~>
  class { '::wordpress::service': } ->
  Class['::wordpress']
}
