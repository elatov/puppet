# Class: psacct
# ===========================
#
# Full description of class psacct here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class psacct (
  $package_name = $::psacct::params::package_name,
  $service_name = $::psacct::params::service_name,
) inherits ::psacct::params {

  # validate parameters here

  class { '::psacct::install': } ->
  class { '::psacct::config': } ~>
  class { '::psacct::service': } ->
  Class['::psacct']
}
