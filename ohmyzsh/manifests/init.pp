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
  $package_name = $::ohmyzsh::params::package_name,
  $service_name = $::ohmyzsh::params::service_name,
) inherits ::ohmyzsh::params {

  # validate parameters here

  class { '::ohmyzsh::install': } ->
  class { '::ohmyzsh::config': } ~>
  # class { '::ohmyzsh::service': } ->
  Class['::ohmyzsh']
}
