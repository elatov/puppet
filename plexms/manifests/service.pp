# == Class plexms::service
#
# This class is meant to be called from plexms
# It ensure the service is running
#
class plexms::service{

  service { $plexms::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
