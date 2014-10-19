# == Class sendmail::service
#
# This class is meant to be called from sendmail
# It ensure the service is running
#
class sendmail::service {

  service { $sendmail::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
