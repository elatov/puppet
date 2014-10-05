# == Class ossec::client::service
#
# This class is meant to be called from ossec::client
# It ensure the service is running
#
class ossec::client::service inherits ossec::params{

  if !$ossec_client_settings['initial_setup'] { 
    service { $ossec_client_service_name:
	    ensure     => running,
	    enable     => true,
	    hasstatus  => true,
	    hasrestart => true,
    }
  }else {
    service { $ossec_client_service_name:
      ensure     => stopped,
      enable     => false,
      hasstatus  => true,
      hasrestart => true,
    }->
    notify{"Go setup the client on the ossec server":}
  }
  
}
