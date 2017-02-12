# == Class psacct::service
#
# This class is meant to be called from psacct.
# It ensure the service is running.
#
class psacct::service {

	case $::osfamily {
		/(?i:Debian|Redhat)/:{
			service { $::psacct::service_name:
				ensure     => running,
				enable     => true,
				hasstatus  => true,
				hasrestart => true,
			}
		}
		/(?i:FreeBSD)/:{
		  augeas { "${module_name}-rcconf-acct":
        incl    => "/etc/rc.conf",
        context => "/files/etc/rc.conf",
        lens    => "Shellvars.lns",
        onlyif  => "get accounting_enable != '\"YES\"'",
        changes => [
        # track which key was used to logged in
          "set accounting_enable '\"YES\"'",
        ],
      }
		}
		default: {
		  fail("${::operatingsystem} not supported")
		}
  }  
}
