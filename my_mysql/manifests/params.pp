# == Class my_mysql::params
#
# This class is meant to be called from my_mysql
# It sets variables according to platform
#
class my_mysql::params {

	$my_mysql_server_settings	=	{ 'user' 	=> 'elatov',
												  'host'	=> $::hostname,
												}
										
	$my_mysql_client_settings	=	{ 'user' 	=> 'elatov',
												  'host'	=> $::hostname,
												}
	case $::osfamily {
		'Debian': {
			### Server
			$my_mysql_server_package_name		= 'my_mysql'
			$my_mysql_server_service_name		= 'my_mysql'
			$my_mysql_server_config_dir			= '/etc/default'
			$my_mysql_server_service_dir		= '/etc/init.d'
			$my_mysql_server_home						= '/usr/local/my_mysql'
			$my_mysql_server_config_file		= 'my_mysql.sysconf.init'
			$my_mysql_server_service_file		= 'my_mysql.init'
			
			### Client
			$my_mysql_client_package_name		= 'my_mysql'
			$my_mysql_client_service_name		= 'my_mysql'
			$my_mysql_client_config_dir			= '/etc/default'
			$my_mysql_client_service_dir		= '/etc/init.d'
			$my_mysql_client_home						= "/home/${my_mysql_client_settings['user']}/.my_mysql"
			$my_mysql_client_config_file		= 'my_mysql.config'
			$my_mysql_client_service_file		= 'my_mysql.init'
		}
		'RedHat': {
			### Server
			$my_mysql_server_package_name		= 'my_mysql'
			$my_mysql_server_service_name		= 'my_mysql'
			$my_mysql_server_config_dir			= '/etc/sysconfig'
			$my_mysql_server_home						= '/usr/local/my_mysql'
			
			### Client
			$my_mysql_client_package_name		= 'my_mysql'
			$my_mysql_client_service_name		= 'my_mysql'
			$my_mysql_client_config_dir			= '/etc/sysconfig'
			$my_mysql_client_home						= "/home/${my_mysql_client_settings['user']}.my_mysql"
			
			if $::operatingsystemmajrelease >= 7 {
				### Server
				$my_mysql_server_service_dir  	= '/usr/lib/systemd/system'
				$my_mysql_server_config_file  	= 'my_mysql.sysconf.systemd'
				$my_mysql_server_service_file 	= 'my_mysql.service'
				
				### Client
				$my_mysql_client_service_dir  	= '/usr/lib/systemd/system'
				$my_mysql_client_config_file  	= 'my_mysql.conf.systemd'
				$my_mysql_client_service_file 	= 'my_mysql.service'
			}else{
				### Server
				$my_mysql_server_service_dir		= '/etc/init.d'
				$my_mysql_server_config_file		= 'my_mysql.conf.init'
				$my_mysql_server_service_file	= 'my_mysql.init'
				
				### Client
				$my_mysql_client_service_dir		= '/etc/init.d'
				$my_mysql_client_config_file		= 'my_mysql.conf.init'
				$my_mysql_client_service_file		= 'my_mysql.init'
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
