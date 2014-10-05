# == Class ossec::server::service
#
# This class is meant to be called from ossec
# It ensure the service is running
#
class ossec::server::service inherits ossec::params{

  service { $ossec_server_service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
