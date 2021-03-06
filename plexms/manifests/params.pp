# == Class plexms::params
#
# This class is meant to be called from plexms
# It sets variables according to platform
#
class plexms::params {

	$plexms_settings_all	=	{ 'conf'  => {'User' 	=> 'test',
										                    'Group'	=> 'test',
										                   }
										      }

	case $::osfamily {
		'Debian': {
			$plexms_package_name		= 'plexmediaserver'
			$plexms_service_name		= 'plexms'
			$plexms_config_dir			= '/etc/default'
			$plexms_service_dir			= '/etc/init.d'
			$plexms_home						= '/var/lib/plexmediaserver'
			$plexms_config_file			= 'plexms.sysconf.init'
			$plexms_service_file		= 'plexms.init'
			$plexms_settings_os     = {'apt_source' => 'APT_Plex_Source'}
		}
		'RedHat': {
		  ### Package
			$plexms_package_name		= 'plexmediaserver'
			### Service
			$plexms_service_name		= 'plexmediaserver'
			### Dir
			$plexms_config_dir			= '/etc/sysconfig'
			$plexms_home_dir			  = '/var/lib/plexmediaserver'
			### Settings
			$plexms_settings_os     = {'use_rpm'   => true,
			                           'rpm_name'  => 'plexmediaserver-0.9.16.3.1840-cece46d.x86_64.rpm'
			                          }
			
			if (versioncmp($::operatingsystemmajrelease, '7') >= 0) {
				$plexms_service_dir  	= '/lib/systemd/system'
				$plexms_config_file  	= 'plexms.sysconf.systemd'
				$plexms_service_file 	= 'plexmediaserver.service'
			}else{
				$plexms_service_dir		= '/etc/init.d'
				$plexms_config_file		= 'plexms.sysconf.init'
				$plexms_service_file	= 'plexmediaserver.init'
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$plexms_default_settings = merge($plexms_settings_all,$plexms_settings_os)
}
