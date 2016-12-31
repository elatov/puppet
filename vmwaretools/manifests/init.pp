# Class: vmwaretools
# ===========================
#
# Full description of class vmwaretools here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class vmwaretools (
  $package_name = $::vmwaretools::params::package_name,
  $service_name = $::vmwaretools::params::service_name,
) inherits ::vmwaretools::params {

  # validate parameters here

  class { '::vmwaretools::install': } ->
  class { '::vmwaretools::config': } ~>
  class { '::vmwaretools::service': } ->
  Class['::vmwaretools']
}
