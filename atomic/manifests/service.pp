# == Class atomic::service
#
# This class is meant to be called from atomic
# It ensure the service is running
#
class atomic::service inherits atomic::params{

  service { $atomic_service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
