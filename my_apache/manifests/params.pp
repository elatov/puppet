# == Class my_apache::params
#
# This class is meant to be called from my_apache
# It sets variables according to platform
#
class my_apache::params {

	$my_apache_settings	=	{
										'conf_proxy' 	    => 'splunk-proxy.conf',
										'hostname'	      => $::hostname,
										'php_pkg'         => 'libapache2-mod-php5',
                    'proxy_html_pkg'  => 'libapache2-mod-proxy-html',
										}
	case $::osfamily {
		'Debian': {
#			$my_apache_package_name		= 'my_apache'
#			$my_apache_service_name		= 'my_apache'
			$my_apache_config_dir			= '/etc/apache2/conf.d'
			#$my_apache_service_dir			= '/etc/init.d'
#			$my_apache_home						= '/usr/local/my_apache'
#			$my_apache_config_file			= 'my_apache.sysconf.init'
#			$my_apache_service_file		= 'my_apache.init'
		}
		'RedHat': {
			$my_apache_package_name		= 'my_apache'
			$my_apache_service_name		= 'my_apache'
			$my_apache_config_dir			= '/etc/sysconfig'
			$my_apache_home						= '/usr/local/my_apache'
			
			if $::operatingsystemmajrelease >= 7 {
				$my_apache_service_dir  	= '/usr/lib/systemd/system'
				$my_apache_config_file  	= 'my_apache.sysconf.systemd'
				$my_apache_service_file 	= 'my_apache.service'
			}else{
				$my_apache_service_dir		= '/etc/init.d'
				$my_apache_config_file		= 'my_apache.sysconf.init'
				$my_apache_service_file	= 'my_apache.init'
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
