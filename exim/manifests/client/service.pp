# == Class exim::client::service
#
# This class is meant to be called from exim::client
# It ensure the service is running
#
class exim::client::service {

  service { $exim::client::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
