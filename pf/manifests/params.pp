# == Class pf::params
#
# This class is meant to be called from pf
# It sets variables according to platform
#
class pf::params {

	$pf_settings	=	{
										'user' 	=> 'elatov',
										'host'	=> $::hostname,
										}
	case $::osfamily {
		'Debian': {
			$pf_package_name		= 'pf'
			$pf_service_name		= 'pf'
			$pf_config_dir			= '/etc/default'
			$pf_service_dir			= '/etc/init.d'
			$pf_home						= '/usr/local/pf'
			$pf_config_file			= 'pf.sysconf.init'
			$pf_service_file		= 'pf.init'
		}
		'RedHat': {
			$pf_package_name		= 'pf'
			$pf_service_name		= 'pf'
			$pf_config_dir			= '/etc/sysconfig'
			$pf_home						= '/usr/local/pf'
			
			if $::operatingsystemmajrelease >= 7 {
				$pf_service_dir  	= '/usr/lib/systemd/system'
				$pf_config_file  	= 'pf.sysconf.systemd'
				$pf_service_file 	= 'pf.service'
			}else{
				$pf_service_dir		= '/etc/init.d'
				$pf_config_file		= 'pf.sysconf.init'
				$pf_service_file	= 'pf.init'
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
