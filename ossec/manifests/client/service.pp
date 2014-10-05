# == Class ossec::client::service
#
# This class is meant to be called from ossec::client
# It ensure the service is running
#
class ossec::client::service{

  if !$ossec::client::settings['initial_setup'] { 
    service { $ossec::client::service_name:
	    ensure     => running,
	    enable     => true,
	    hasstatus  => true,
	    hasrestart => true,
    }
  }else {
    service { $ossec::client::service_name:
      ensure     => stopped,
      enable     => false,
      hasstatus  => true,
      hasrestart => true,
    }->
    notify{"Go setup the client on the ossec server":}
  }
  
}
