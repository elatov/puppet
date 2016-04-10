# == Class my_mysql::params
#
# This class is meant to be called from my_mysql
# It sets variables according to platform
#
class my_mysql::params {

	$my_mysql_settings	=	{ 'root_password'	=> 'password',
										    }
	case $::osfamily {
		'Debian': {
			$my_mysql_config_dir			= '/etc/mysql/conf.d'
			$my_mysql_config_file     = 'mysql_innodb_data.cnf'
			$my_mysql_package_name    = 'mariadb-server'
		}
		'RedHat': {
			$my_mysql_package_name		= 'my_mysql'
			$my_mysql_service_name		= 'my_mysql'
			$my_mysql_config_dir			= '/etc/sysconfig'
			$my_mysql_home						= '/usr/local/my_mysql'
			
			if $::operatingsystemmajrelease >= 7 {
				$my_mysql_service_dir  	= '/usr/lib/systemd/system'
				$my_mysql_config_file  	= 'my_mysql.sysconf.systemd'
				$my_mysql_service_file 	= 'my_mysql.service'
			}else{
				$my_mysql_service_dir		= '/etc/init.d'
				$my_mysql_config_file		= 'my_mysql.sysconf.init'
				$my_mysql_service_file	= 'my_mysql.init'
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
