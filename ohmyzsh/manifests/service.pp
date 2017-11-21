# == Class ohmyzsh::service
#
# This class is meant to be called from ohmyzsh.
# It ensure the service is running.
#
class ohmyzsh::service {

  service { $::ohmyzsh::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
