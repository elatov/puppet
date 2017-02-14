# == Class psacct::install
#
# This class is called from psacct for install.
#
class psacct::install {
  
	case $::osfamily {
		/(?i:Debian|Redhat)/:{
			package { $::psacct::package_name:
			 ensure => present,
			}
		}
		/(?i:FreeBSD)/:{
			file {'/var/account/acct':
				ensure  => 'present',
				mode    => '0644',
			} ->
			exec { "${module_name}-accton":
			 command => "/usr/sbin/accton /var/account/acct",
			 unless  => "/bin/test -s /var/account/acct"
			}
		}
		default: {
		  fail("${::operatingsystem} not supported")
		}  
	}
	
}
