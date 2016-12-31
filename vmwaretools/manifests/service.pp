# == Class vmwaretools::service
#
# This class is meant to be called from vmwaretools.
# It ensure the service is running.
#
class vmwaretools::service {

  service { $::vmwaretools::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
