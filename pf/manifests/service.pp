# == Class pf::service
#
# This class is meant to be called from pf
# It ensure the service is running
#
class pf::service {

  service { $pf::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
