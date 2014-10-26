# == Class nfs::params
#
# This class is meant to be called from nfs
# It sets variables according to platform
#
class nfs::params {

	$nfs_server_settings_all	=	{ 'host'	=> $::hostname,
								              }
										
	$nfs_client_settings_all	=	{ 'user' 	=> 'test',
								                'host'	=> $::hostname,
								              }
	case $::osfamily {
		'Debian': {
			### Client
			$nfs_client_package_name		= 'nfs'
			$nfs_client_package_name		= 'nfs'
			$nfs_client_service_name		= 'nfs'
			$nfs_client_config_dir			= '/etc/default'
			$nfs_client_service_dir			= '/etc/init.d'
			$nfs_client_config_file			= 'nfs.config'
			$nfs_client_service_file		= 'nfs.init'
			$nfs_client_settings_os     = {}
		}
		'RedHat': {
			### Server
			## Package
			$nfs_server_package_name		= 'nfs-utils'
			## Service
			$nfs_server_service_name    = 'nfs-server'
			$nfs_server_service_pre     = 'rpcbind'
      ## Dirs
      ## Conf File
      $nfs_server_exports_file    = '/etc/exports'
			## Settings
			$nfs_server_settings_os     = { 'exports'  => {'/tmp' => "127.0.0.1/32(rw)"} }
		
			### Client
			$nfs_client_package_name		= 'nfs'
			$nfs_client_service_name		= 'nfs'
			
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$nfs_client_default_settings = merge($nfs_client_settings_all,$nfs_client_settings_os)
	$nfs_server_default_settings = merge($nfs_server_settings_all,$nfs_server_settings_os)
}
