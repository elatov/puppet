# == Class dock_compose::service
#
# This class is meant to be called from dock_compose.
# It ensure the service is running.
#
class dock_compose::service {

  service { $::dock_compose::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
