# == Class nfs::server::service
#
# This class is meant to be called from nfs
# It ensure the service is running
#
class nfs::server::service{

  if ($nfs::server::service_pre != undef){
		service { $nfs::server::service_pre:
			ensure     => running,
			enable     => true,
			hasstatus  => true,
			hasrestart => true,
		}->
		service { $nfs::server::service_name:
			ensure     => running,
			enable     => true,
			hasstatus  => true,
			hasrestart => true,
		}
	}else {
	  service { $nfs::server::service_name:
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
	}
}
