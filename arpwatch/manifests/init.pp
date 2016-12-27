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
) inherits ::arpwatch::params {

  # validate parameters here

  class { '::arpwatch::install': } ->
  class { '::arpwatch::config': } ~>
  class { '::arpwatch::service': } ->
  Class['::arpwatch']
}
