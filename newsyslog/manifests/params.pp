# == Class newsyslog::params
#
# This class is meant to be called from newsyslog
# It sets variables according to platform
#
class newsyslog::params {

	$newsyslog_settings	=	{
										'user' 	=> 'elatov',
										'host'	=> $::hostname,
										}
	case $::osfamily {
		'Debian': {
			$newsyslog_package_name		= 'newsyslog'
			$newsyslog_service_name		= 'newsyslog'
			$newsyslog_config_dir			= '/etc/default'
			$newsyslog_service_dir			= '/etc/init.d'
			$newsyslog_home						= '/usr/local/newsyslog'
			$newsyslog_config_file			= 'newsyslog.sysconf.init'
			$newsyslog_service_file		= 'newsyslog.init'
		}
		'RedHat': {
			$newsyslog_package_name		= 'newsyslog'
			$newsyslog_service_name		= 'newsyslog'
			$newsyslog_config_dir			= '/etc/sysconfig'
			$newsyslog_home						= '/usr/local/newsyslog'
			
			if $::operatingsystemmajrelease >= 7 {
				$newsyslog_service_dir  	= '/usr/lib/systemd/system'
				$newsyslog_config_file  	= 'newsyslog.sysconf.systemd'
				$newsyslog_service_file 	= 'newsyslog.service'
			}else{
				$newsyslog_service_dir		= '/etc/init.d'
				$newsyslog_config_file		= 'newsyslog.sysconf.init'
				$newsyslog_service_file	= 'newsyslog.init'
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
