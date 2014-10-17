# == Class smartd::service
#
# This class is meant to be called from smartd
# It ensure the service is running
#
class smartd::service {

  service { $smartd::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
