# == Class iptables::service
#
# This class is meant to be called from iptables
# It ensure the service is running
#
class iptables::service {

	case $::operatingsystem {
		/(?i:CentOS|fedora)/: { 
			service { $iptables::service_name:
				ensure     => running,
				enable     => true,
				hasstatus  => true,
				hasrestart => true,
			}
		}
		/(?i:Debian|Ubuntu)/: {
		  if ($::operatingsystemmajrelease == '10') {
		    service { $iptables::service_name:
		      provider => systemd,
	        ensure     => running,
	        enable     => true,
	        hasstatus  => true,
	        hasrestart => true,
        } 
      } else {
			  service { $iptables::service_name:
		      ensure     => undef,
		      enable     => true,
		      hasstatus  => true,
		      hasrestart => true,
	      }~>
	      exec {'restart-iptables':
	        #path        => ["/sbin","/usr/sbin"],
	        provider    => "posix",
	        command     => '/etc/init.d/iptables-persistent restart',
	        refreshonly => true,
	      }
	    }
		}
		default: {
		  service { $iptables::service_name:
	      ensure     => running,
	      enable     => true,
	      hasstatus  => true,
	      hasrestart => true,
      }
		}
	}
}
