# == Class wordpress::service
#
# This class is meant to be called from wordpress.
# It ensure the service is running.
#
class wordpress::service {

  service { $::wordpress::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
