# == Class plexms::params
#
# This class is meant to be called from plexms
# It sets variables according to platform
#
class plexms::params {

	$plexms_settings	=	{
										'user' 	=> 'test',
										'group'	=> 'test',
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
			$plexms_apt_source      = 'APT_Plex_Source'
		}
		'RedHat': {
			$plexms_package_name		= 'plexmediaserver'
			$plexms_service_name		= 'plexmediaserver'
			$plexms_config_dir			= '/etc/sysconfig'
			$plexms_home						= '/var/lib/plexmediaserver'
			$plexms_use_rpm         = true
			if ($plexms_use_rpm){
			  $plexms_rpm_name      = 'plexmediaserver-0.9.9.14.531-7eef8c6.x86_64.rpm'
			} else {
			  $plexms_yum_repo        = 'PlexRepo'
			}
			
			if $::operatingsystemmajrelease >= 7 {
				$plexms_service_dir  	= '/usr/lib/systemd/system'
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
}
