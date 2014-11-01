# == Class extra_conf::params
#
# This class is meant to be called from extra_conf
# It sets variables according to platform
#
class extra_conf::params {

	$extra_conf_settings	=	{
										'user' 	=> 'test',
										'host'	=> $::hostname,
										}
	case $::osfamily {
		'Debian': {
			$extra_conf_package_name		= 'extra_conf'
			$extra_conf_service_name		= 'extra_conf'
			$extra_conf_config_dir			= '/etc/default'
			$extra_conf_service_dir			= '/etc/init.d'
			$extra_conf_home						= '/usr/local/extra_conf'
			$extra_conf_config_file			= 'extra_conf.sysconf.init'
			$extra_conf_service_file		= 'extra_conf.init'
		}
		'RedHat': {
			$extra_conf_package_name		= 'extra_conf'
			$extra_conf_service_name		= 'extra_conf'
			$extra_conf_config_dir			= '/etc/sysconfig'
			$extra_conf_home						= '/usr/local/extra_conf'
			
			if $::operatingsystemmajrelease >= 7 {
				$extra_conf_service_dir  	= '/usr/lib/systemd/system'
				$extra_conf_config_file  	= 'extra_conf.sysconf.systemd'
				$extra_conf_service_file 	= 'extra_conf.service'
			}else{
				$extra_conf_service_dir		= '/etc/init.d'
				$extra_conf_config_file		= 'extra_conf.sysconf.init'
				$extra_conf_service_file	= 'extra_conf.init'
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
