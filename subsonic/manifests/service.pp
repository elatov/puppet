# == Class subsonic::service
#
# This class is meant to be called from subsonic
# It ensure the service is running
#
class subsonic::service inherits subsonic{

  service { $subsonic_service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
