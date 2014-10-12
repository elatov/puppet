# == Class newsyslog::service
#
# This class is meant to be called from newsyslog
# It ensure the service is running
#
class newsyslog::service {

  service { $newsyslog::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
