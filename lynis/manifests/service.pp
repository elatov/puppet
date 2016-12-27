# == Class lynis::service
#
# This class is meant to be called from lynis.
# It ensure the service is running.
#
class lynis::service {

#  service { $::lynis::service_name:
#    ensure     => running,
#    enable     => true,
#    hasstatus  => true,
#    hasrestart => true,
#  }
}
