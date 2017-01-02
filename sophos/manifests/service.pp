# == Class sophos::service
#
# This class is meant to be called from sophos.
# It ensure the service is running.
#
class sophos::service {
  if !$sophos::initial_setup {
	  service { $::sophos::service_name:
	    ensure     => running,
	    enable     => true,
	    hasstatus  => true,
	    hasrestart => true,
	  }
	  
  }
}
