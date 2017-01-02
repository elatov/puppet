# Class: sophos
# ===========================
#
# Full description of class sophos here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class sophos (
  $package_name = $::sophos::params::package_name,
  $service_name = $::sophos::params::service_name,
) inherits ::sophos::params {

  # validate parameters here

  class { '::sophos::install': } ->
  class { '::sophos::config': } ~>
  class { '::sophos::service': } ->
  Class['::sophos']
}
