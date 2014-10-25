# == Class atomic::params
#
# This class is meant to be called from atomic
# It sets variables according to platform
#
class atomic::params {

	$atomic_settings	=	{
										'includepkgs' 	=> "ossec-hids* atomic-release* inotify-tools*",
										}
	$atomic_user      = "elatov"
	case $::osfamily {
		'RedHat': {
		  if ($::operatingsystem == "CentOS" and $::operatingsystemmajrelease >= 7) {
			 $atomic_rpm_name		= 'atomic-release-1.0-19.el7.art.noarch.rpm'
      }
			$atomic_config_dir			  = '/etc/yum.repos.d'
			$atomic_config_file       = 'atomic.repo'
	
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
