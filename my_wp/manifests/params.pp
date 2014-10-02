# == Class my_wp::params
#
# This class is meant to be called from my_wp
# It sets variables according to platform
#
class my_wp::params {

	$my_wp_settings	=	{
										'user' 	=> 'elatov',
										'host'	=> $::hostname,
										}
	case $::osfamily {
		'Debian': {
			$my_wp_package_name		= 'my_wp'
			$my_wp_service_name		= 'my_wp'
			$my_wp_config_dir			= '/etc/default'
			$my_wp_service_dir			= '/etc/init.d'
			$my_wp_home						= '/usr/local/my_wp'
			$my_wp_config_file			= 'my_wp.sysconf.init'
			$my_wp_service_file		= 'my_wp.init'
		}
		'RedHat': {
			$my_wp_package_name		= 'my_wp'
			$my_wp_service_name		= 'my_wp'
			$my_wp_config_dir			= '/etc/sysconfig'
			$my_wp_home						= '/usr/local/my_wp'
			
			if $::operatingsystemmajrelease >= 7 {
				$my_wp_service_dir  	= '/usr/lib/systemd/system'
				$my_wp_config_file  	= 'my_wp.sysconf.systemd'
				$my_wp_service_file 	= 'my_wp.service'
			}else{
				$my_wp_service_dir		= '/etc/init.d'
				$my_wp_config_file		= 'my_wp.sysconf.init'
				$my_wp_service_file	= 'my_wp.init'
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
