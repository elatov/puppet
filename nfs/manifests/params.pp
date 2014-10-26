# == Class nfs::params
#
# This class is meant to be called from nfs
# It sets variables according to platform
#
class nfs::params {

	$nfs_server_settings	=	{ 'host'	=> $::hostname,
								}
										
	$nfs_client_settings	=	{ 'user' 	=> 'test',
								  'host'	=> $::hostname,
								}
	case $::osfamily {
		'Debian': {
			### Server
			$nfs_server_package_name		= 'nfs'
			$nfs_server_package_name		= 'nfs'
			$nfs_server_service_name		= 'nfs'
			$nfs_server_config_dir			= '/etc/default'
			$nfs_server_service_dir			= '/etc/init.d'
			$nfs_server_home						= '/usr/local/nfs'
			$nfs_server_config_file			= 'nfs.sysconf.init'
			$nfs_server_service_file		= 'nfs.init'
			
			### Client
			$nfs_client_package_name		= 'nfs'
			$nfs_client_package_name		= 'nfs'
			$nfs_client_service_name		= 'nfs'
			$nfs_client_config_dir			= '/etc/default'
			$nfs_client_service_dir			= '/etc/init.d'
			$nfs_client_home						= "/home/${nfs_client_settings}['user']}/.nfs"
			$nfs_client_config_file			= 'nfs.config'
			$nfs_client_service_file		= 'nfs.init'
		}
		'RedHat': {
			### Server
			$nfs_server_package_name		= 'nfs-utils'
			
#			$nfs_server_config_dir			= '/etc/sysconfig'
#			$nfs_server_home						= '/usr/local/nfs'
      $nfs_server_exports_file    = '/etc/exports'
			
			### Client
			$nfs_client_package_name		= 'nfs'
			$nfs_client_service_name		= 'nfs'
#			$nfs_client_config_dir			= '/etc/sysconfig'
#			$nfs_client_home						= "/home/${nfs_client_settings['user']}.nfs"
			
			if $::operatingsystemmajrelease >= 7 {
				### Server
				$nfs_server_service_name  = 'nfs-server'
				$nfs_server_service_dir  	= '/usr/lib/systemd/system'
				$nfs_server_config_file  	= 'nfs.sysconf.systemd'
				$nfs_server_service_file 	= 'nfs.service'
				
				### Client
				$nfs_client_service_dir  	= '/usr/lib/systemd/system'
				$nfs_client_config_file  	= 'nfs.conf.systemd'
				$nfs_client_service_file 	= 'nfs.service'
			}else{
				### Server
				$nfs_server_service_dir		= '/etc/init.d'
				$nfs_server_config_file		= 'nfs.conf.init'
				$nfs_server_service_file	= 'nfs.init'
				
				### Client
				$nfs_client_service_dir		= '/etc/init.d'
				$nfs_client_config_file		= 'nfs.conf.init'
				$nfs_client_service_file	= 'nfs.init'
			}
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
