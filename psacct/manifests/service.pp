# == Class psacct::service
#
# This class is meant to be called from psacct.
# It ensure the service is running.
#
class psacct::service {

  service { $::psacct::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
