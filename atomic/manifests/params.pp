# == Class atomic::params
#
# This class is meant to be called from atomic
# It sets variables according to platform
#
class atomic::params {

	$atomic_settings_all	=	{	'yum_conf'  => { 'includepkgs' 	=> "ossec-hids* atomic-release* inotify-tools*", },
										      }
	case $::osfamily {
		'RedHat': {
		  if ($::operatingsystem == "CentOS" and $::operatingsystemmajrelease >= 7) {
			 $atomic_package_name		= 'atomic-release-1.0-19.el7.art.noarch.rpm'
      }
			$atomic_config_dir			  = '/etc/yum.repos.d'
			$atomic_config_file       = 'atomic.repo'
			$atomic_settings_os       = {}
	
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$atomic_default_settings = merge($atomic_settings_all,$atomic_settings_os)
}
