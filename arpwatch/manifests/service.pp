# == Class arpwatch::service
#
# This class is meant to be called from arpwatch.
# It ensure the service is running.
#
class arpwatch::service {

  service { $::arpwatch::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
