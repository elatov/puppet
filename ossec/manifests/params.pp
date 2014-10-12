# == Class ossec::params
#
# This class is meant to be called from ossec
# It sets variables according to platform
#
class ossec::params {

	$ossec_server_default_settings	=	{ 'adduser' 	=> 'elatov',
										                  'config'    => { 'email_to'     => "user@${::fqdn}",
                                                       'smtp_server'  => '127.0.0.1',
                                                       'email_from'   => "ossecm@${::domain}",}
										                }
										
	$ossec_client_default_settings	=	{ 'user' 	        => 'ossec',
										                  'add_user'      => 'elatov',
										                  'server_ip'	    => $::ipaddress,
										                  'timezone_file' => '/usr/share/zoneinfo/America/Denver',
                                      'initial_setup' =>  true,
										                }
	case $::osfamily {
		'Debian': {
			### Server
			$ossec_server_package_name		= 'ossec'
			$ossec_server_service_name		= 'ossec'
			$ossec_server_config_dir			= '/etc/default'
			$ossec_server_service_dir			= '/etc/init.d'
			$ossec_server_home						= '/usr/local/ossec'
			$ossec_server_config_file			= 'ossec.sysconf.init'
			$ossec_server_service_file		= 'ossec.init'
			
			### Client
			$ossec_client_package_name		= 'ossec-hids-agent'
			$ossec_client_service_name		= 'ossec'
			$ossec_client_config_dir			= '/var/ossec/etc'
			$ossec_client_service_dir			= '/etc/init.d'
			$ossec_client_home						= '/var/ossec'
			$ossec_client_config_file			= "ossec-agent.conf.${::operatingsystem}"
			$ossec_client_service_file		= 'ossec.init'
		}
		'RedHat': {
			### Server
			$ossec_server_package_name		= 'ossec'
			$ossec_server_service_name		= 'ossec'
			$ossec_server_config_dir			= '/etc/sysconfig'
			$ossec_server_home						= '/usr/local/ossec'
			
			### Client
			$ossec_client_package_name		= 'ossec-hids-client'
			$ossec_client_service_name		= 'ossec-hids'
			$ossec_client_config_dir			= '/var/ossec/etc'
			$ossec_client_home						= '/var/ossec'
			
			if $::operatingsystemmajrelease >= 7 {
				### Server
				$ossec_server_service_dir  	= '/usr/lib/systemd/system'
				$ossec_server_config_file  	= 'ossec.sysconf.systemd'
				$ossec_server_service_file 	= 'ossec.service'
				
				### Client
				#$ossec_client_service_dir  	= '/usr/lib/systemd/system'
				$ossec_client_config_file  	= "ossec-agent.conf.${::operatingsystem}"
				#$ossec_client_service_file 	= 'ossec.service'
			}else{
				### Server
				$ossec_server_service_dir		= '/etc/init.d'
				$ossec_server_config_file		= 'ossec.conf.init'
				$ossec_server_service_file	= 'ossec.init'
				
				### Client
				$ossec_client_service_dir		= '/etc/init.d'
				$ossec_client_config_file		= 'ossec.conf.init'
				$ossec_client_service_file	= 'ossec.init'
			}
		}
		'FreeBSD': {
      ### Server
      $ossec_server_package_name    = 'ossec-hids-server'
      $ossec_server_service_name    = 'ossec-hids'
      $ossec_server_config_dir      = '/usr/local/ossec-hids/etc'
      $ossec_server_home            = '/usr/local/ossec-hids'
      $ossec_server_config_file     = 'ossec.conf'
      
      ### Client
      $ossec_client_package_name    = 'ossec-hids-agent'
      $ossec_client_service_name    = 'ossec'
      $ossec_client_config_dir      = '/var/ossec/etc'
      $ossec_client_service_dir     = '/etc/init.d'
      $ossec_client_home            = '/var/ossec'
      $ossec_client_config_file     = "ossec-agent.conf.${::operatingsystem}"
      $ossec_client_service_file    = 'ossec.init'
    }
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
