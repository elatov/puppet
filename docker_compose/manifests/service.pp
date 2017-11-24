# == Class docker_compose::service
#
# This class is meant to be called from docker_compose.
# It ensure the service is running.
#
class docker_compose::service {

  service { $::docker_compose::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
