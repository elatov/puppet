# == Class sendmail::service
#
# This class is meant to be called from sendmail
# It ensures the service is running
#
class sendmail::service {

  service { $sendmail::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
  if ($sendmail::settings['enable_smtp_notify']){
	  service { 'smtp-notify' :
	    ensure     => running,
	    enable     => true,
	    hasstatus  => true,
	    hasrestart => true,
	  }
  }
}
