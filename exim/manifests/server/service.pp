# == Class exim::server::service
#
# This class is meant to be called from exim
# It ensure the service is running
#
class exim::server::service {

  service { $exim::server::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
