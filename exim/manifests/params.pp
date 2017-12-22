# == Class exim::params
#
# This class is meant to be called from exim
# It sets variables according to platform
#
class exim::params {

  $exim_server_initial_setup    = false
	$exim_server_settings_all	    =	{ 'add_user'        => 'test',
										                'host'            => $::hostname,
										                'aliases'         => ['root'],
										                'alias_recipient' => 'root',
                                    'aliases_file'		=> '/etc/aliases',
										              }
										
	$exim_client_settings_all    	=	{ 'add_user' 	      => 'test',
										                'smart_relayhost'	=> $::hostname,
										                'aliases'         => ['root','test'],
										                'alias_recipient' => 'root',
										              }
	case $::osfamily {
    'Archlinux': {
			### Client
			## Package
			$exim_client_package_name		= 'exim'
			## Service
			$exim_client_service_name		= 'exim'
			## Directories
			$exim_client_config_dir			= '/etc/mail'
			## Config Files
			$exim_client_config_file  	= 'exim.conf'
			### settings
			$exim_client_settings_os    = { 'stopped_services'  => ['postfix','sendmail'],
			                                'absent_packages'   => ['postfix','sendmail'],
																			'aliases_file'			=> '/etc/mail/aliases',
			                              }
		}
		'Debian': {
			### Server
			$exim_server_package_name        = 'exim4'
			$exim_server_service_name        = 'exim4'
			$exim_server_config_dir          = '/etc/exim4'
      $exim_server_template_conf_dir   = '/etc/exim4/conf.d'
			$exim_server_config_file         = 'update-exim4.conf.conf'
			$exim_server_passwd_file         = 'passwd.client'
      $exim_server_template_conf_file  = 'main/02_exim4-config_options'
      $exim_server_settings_os         = { 'config' => { 'dc_eximconfig_configtype' => 'smarthost',
                                                         'dc_other_hostnames'       => "$::fqdn",
                                                         'dc_local_interfaces'      => "127.0.0.1:$::ipaddress",
                                                         'dc_minimaldns'            => "true",
                                                         'dc_relay_nets'            => '192.168.1.0/24',
                                                         'dc_smarthost'             => 'smtp.gmail.com::587',
                                                         'dc_use_split_config'      => "true",
                                                         'dc_hide_mailname'         => "false",}
                                         }
			
			### Client
			$exim_client_package_name		    = 'exim4'
			$exim_client_service_name		    = 'exim4'
			$exim_client_config_dir			    = '/etc/exim4'
			$exim_client_service_dir		    = '/etc/init.d'
			$exim_client_config_file		    = 'exim4.conf.template'
      $exim_client_template_conf_file = 'update-exim4.conf.conf'
			$exim_client_settings_os        = { 'stopped_services'  => ['postfix','sendmail'],
			                                    'absent_packages'   => ['postfix','sendmail'],
                                          'config'            => {
                                            'dc_eximconfig_configtype' => 'satellite',
                                            'dc_other_hostnames'       => "email.com",
                                            'dc_local_interfaces'      => "127.0.0.1",
                                            'dc_readhost'              => "${::fqdn}",
                                            'dc_minimaldns'            => "false",
                                            'dc_smarthost'             => 'email.com',
                                            'dc_use_split_config'      => "false",
                                            'dc_hide_mailname'         => "false",
                                          },
                                          'aliases_file'		=> '/etc/aliases',
			                                  }

		}
		'RedHat': {
			### Client
			## Package
			$exim_client_package_name		= 'exim'
			## Service
			$exim_client_service_name		= 'exim'
			## Directories
			$exim_client_config_dir			= '/etc/exim'
			## Config Files
			$exim_client_config_file  	= 'exim.conf'
			### settings
			$exim_client_settings_os    = { 'stopped_services'  => ['postfix','sendmail'],
			                                'absent_packages'   => ['postfix','sendmail'],
                                      'aliases_file'		  => '/etc/aliases',
			                              }
		}
		'FreeBSD': {      
      ## Client
      
      ### Package
      $exim_client_package_name       = 'exim'
      
      ### Service
      $exim_client_service_name       = 'exim'
      
      ### Dirs
      $exim_client_config_dir         = '/usr/local/etc/exim'
      
      ### Conf Files
      $exim_client_config_file        = 'configure'
      $exim_client_rc_conf_file       = '/etc/rc.conf'
      $exim_client_periodic_conf_file = '/etc/periodic.conf'
      $exim_client_maile_conf_file    = '/etc/mail/mailer.conf'

      
      ### Settings
      $exim_client_settings_os     = { 'stopped_services'  => ['sendmail'],
                                       'rc_conf'           => { 'sendmail_enable'           => 'NO',
                                                                'sendmail_submit_enable'    => 'NO',
                                                                'sendmail_outbound_enable'  => 'NO',
                                                                'sendmail_msp_queue_enable' => 'NO',
                                                                'exim_enable'               => 'YES', 
                                                              },
                                       'periodic_conf'     => { 'daily_clean_hoststat_enable'        => 'NO',
                                                                'daily_status_mail_rejects_enable'   => 'NO',
                                                                'daily_status_include_submit_mailq'  => 'NO',
                                                                'daily_submit_queuerun'              => 'NO',
                                                              },
                                        'aliases_file'		  => '/etc/aliases',
                                        }
      
    }
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$exim_server_default_settings = merge($exim_server_settings_all,$exim_server_settings_os)
	$exim_client_default_settings = merge($exim_client_settings_all,$exim_client_settings_os)
}
