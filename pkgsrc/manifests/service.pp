# == Class pkgsrc::service
#
# This class is meant to be called from pkgsrc
# It ensure the service is running
#
class pkgsrc::service {

  service { $pkgsrc::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
