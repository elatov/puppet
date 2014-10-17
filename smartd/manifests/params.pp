# == Class smartd::params
#
# This class is meant to be called from smartd
# It sets variables according to platform
#
class smartd::params {

	$smartd_settings	=	{
										'user' 	=> 'test',
										'host'	=> $::hostname,
										}
	case $::osfamily {
		'Debian': {
			$smartd_package_name		= 'smartd'
			$smartd_service_name		= 'smartd'
			$smartd_config_dir			= '/etc/default'
			$smartd_service_dir			= '/etc/init.d'
			$smartd_home						= '/usr/local/smartd'
			$smartd_config_file			= 'smartd.sysconf.init'
			$smartd_service_file		= 'smartd.init'
		}
		'RedHat': {
			$smartd_package_name		= 'smartd'
			$smartd_service_name		= 'smartd'
			$smartd_config_dir			= '/etc/sysconfig'
			$smartd_home						= '/usr/local/smartd'
			
			if $::operatingsystemmajrelease >= 7 {
				$smartd_service_dir  	= '/usr/lib/systemd/system'
				$smartd_config_file  	= 'smartd.sysconf.systemd'
				$smartd_service_file 	= 'smartd.service'
			}else{
				$smartd_service_dir		= '/etc/init.d'
				$smartd_config_file		= 'smartd.sysconf.init'
				$smartd_service_file	= 'smartd.init'
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
