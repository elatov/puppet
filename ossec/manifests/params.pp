# == Class ossec::params
#
# This class is meant to be called from ossec
# It sets variables according to platform
#
class ossec::params {

	$ossec_server_settings_all	=	{ 'config'    => { 'email_to'     => "user@${::fqdn}",
                                                   'smtp_server'  => '127.0.0.1',
                                                   'email_from'   => "ossecm@${::domain}",}
										            }
										
	$ossec_client_settings_all	=	{ 'server_ip'	    => $::ipaddress,
                                  'initial_setup' =>  true,
										            }
	case $::osfamily {
		'Debian': {
			### Server
			$ossec_server_package_name		= 'ossec'
			$ossec_server_service_name		= 'ossec'
			$ossec_server_config_dir			= '/etc/default'
			$ossec_server_service_dir			= '/etc/init.d'
			$ossec_server_home_dir				= '/usr/local/ossec'
			$ossec_server_config_file			= 'ossec.sysconf.init'
			$ossec_server_service_file		= 'ossec.init'
			
			### Client
			$ossec_client_package_name		= 'ossec-hids-agent'
			$ossec_client_service_name		= 'ossec'
			$ossec_client_config_dir			= '/var/ossec/etc'
			$ossec_client_service_dir			= '/etc/init.d'
			$ossec_client_home_dir				= '/var/ossec'
			$ossec_client_config_file			= "ossec-agent.conf.${::operatingsystem}"
			$ossec_client_service_file		= 'ossec.init'
			$osser_client_settings_os     = { 'add_user'      => 'test',
			                                  'config'        => { 'logs' => { '/var/log/messages'       => 'syslog',
                                                                         '/var/log/auth.log'       => 'syslog',
                                                                         '/var/log/mail.log'       => 'syslog',
                                                                         '/var/log/exim4/mainlog'  => 'syslog',
                                                                         '/var/log/daemon.log'     => 'syslog',
                                                                         '/var/log/syslog'         => 'syslog',
                                                                         "/var/log/apache2/${hostname}_access_log"  => 'apache', 
                                                                         "/var/log/apache2/${hostname}_error_log"  => 'apache',
                                                                         '/var/log/apache2/error_log '  => 'apache', 
                                                                         '/var/log/apache2/access_log '  => 'apache', 
                                                                        }
                                                           }
                                      }
		}
		'RedHat': {
			### Server
			$ossec_server_package_name		= 'ossec'
			$ossec_server_service_name		= 'ossec'
			$ossec_server_config_dir			= '/etc/sysconfig'
			$ossec_server_home_dir				= '/usr/local/ossec'
			
			### Client
			$ossec_client_package_name		= 'ossec-hids-client'
			$ossec_client_service_name		= 'ossec-hids'
			$ossec_client_config_dir			= '/var/ossec/etc'
			$ossec_client_home_dir   			= '/var/ossec'
			$osser_client_settings_os     = { 'timezone_file' => '/usr/share/zoneinfo/America/Denver',
                                        'add_user'      => 'test',
                                        'config'        => { 'logs' => { '/var/log/messages'       => 'syslog',
                                                                         '/var/log/secure'         => 'syslog',
                                                                         '/var/log/maillog'        => 'syslog',
                                                                         '/var/log/exim/main.log'  => 'syslog',
                                                                        }
                                                           }
                                      }
			
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
      $ossec_server_home_dir        = '/usr/local/ossec-hids'
      $ossec_server_config_file     = 'ossec.conf'
      $ossec_server_settings_os     = { add_user  => 'test'}
      
      ### Client
      $ossec_client_package_name    = 'ossec-hids-agent'
      $ossec_client_service_name    = 'ossec'
      $ossec_client_config_dir      = '/var/ossec/etc'
      $ossec_client_service_dir     = '/etc/init.d'
      $ossec_client_home_dir        = '/var/ossec'
      $ossec_client_config_file     = "ossec-agent.conf.${::operatingsystem}"
      $ossec_client_service_file    = 'ossec.init'
    }
    'Solaris': {
      ### Client
      ##Package
      $ossec_client_package_name    = 'ossec-2.8.1-omnios.tar.bz2'
      # Service
      $ossec_client_service_name    = 'ossec'
      ## Dirs
      $ossec_client_config_dir      = '/usr/local/ossec/etc'
      $ossec_client_service_dir     = '/lib/svc/method/'
      $ossec_client_home_dir        = '/usr/local/ossec'
      $ossec_client_manifest_dir    = '/var/svc/manifest/application/'
      ### Files
      $ossec_client_config_file     = "ossec-agent.conf"
      $ossec_client_service_file    = 'ossec.smf'
      $ossec_client_manifest_file   = 'ossec.xml'
      ## Settings
      $ossec_client_settings_os     = { 'config' => { 'logs' => {'/var/log/syslog'    => 'syslog',
                                                                 '/var/log/authlog'   => 'syslog',
                                                                 '/var/adm/auth.log'  => 'syslog',
                                                                 '/var/adm/messages'  => 'syslog',
                                                                }
                                                    }
                                      }
    }
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$ossec_client_default_settings = merge($ossec_client_settings_all,$ossec_client_settings_os)
  $ossec_server_default_settings = merge($ossec_server_settings_all,$ossec_server_settings_os)
}
