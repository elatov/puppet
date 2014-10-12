# == Class exim::params
#
# This class is meant to be called from exim
# It sets variables according to platform
#
class exim::params {

  $exim_server_initial_setup    = false
	$exim_server_settings_all	    =	{ 'add_user'        => 'elatov',
										                'host'            => $::hostname,
										                'aliases'         => ['root','elatov'],
										                'alias_recipient' => 'root'
										              }
										
	$exim_client_settings_all    	=	{ 'add_user' 	      => 'elatov',
										                'smart_relayhost'	=> $::hostname,
										                'aliases'         => ['root','elatov'],
										                'alias_recipient' => 'root'
										              }
	case $::osfamily {
		'Debian': {
			### Server
			$exim_server_package_name        = 'exim4'
			$exim_server_service_name        = 'exim4'
			$exim_server_config_dir          = '/etc/exim4'
      $exim_server_template_conf_dir   = '/etc/exim4/conf.d'
			$exim_server_config_file         = 'update-exim4.conf.conf'
			$exim_server_passwd_file         = 'passwd.client'
      $exim_server_template_conf_file  = 'main/02_exim4-config_options'
      $exim_server_settings_extra      = { 'config' => { 'dc_eximconfig_configtype' => 'smarthost',
                                                         'dc_other_hostnames'       => "$::fqdn",
                                                         'dc_local_interfaces'      => "$::ipaddress",
                                                         'dc_minimaldns'            => "true",
                                                         'dc_relay_nets'            => '192.168.1.0/24',
                                                         'dc_smarthost'             => 'smtp.gmail.com::587',
                                                         'dc_use_split_config'      => "true",
                                                         'dc_hide_mailname'         => "false",}
                                         }
			
			### Client
			$exim_client_package_name		= 'exim'
			$exim_client_service_name		= 'exim'
			$exim_client_config_dir			= '/etc/default'
			$exim_client_service_dir		= '/etc/init.d'
			$exim_client_config_file		= 'exim.config'
			$exim_client_service_file		= 'exim.init'
			$exim_client_absent_packages  = ['postfix','sendmail']
      $exim_client_stopped_services = ['postfix','sendmail' ]
      $exim_client_aliases          = ['root','elatov']
		}
		'RedHat': {
			### Server
			$exim_server_package_name		= 'exim'
			$exim_server_service_name		= 'exim'
			$exim_server_config_dir			= '/etc/sysconfig'
			$exim_server_home						= '/usr/local/exim'
			
			### Client
			$exim_client_package_name		= 'exim'
			$exim_client_service_name		= 'exim'
			$exim_client_config_dir			= '/etc/sysconfig'
			$exim_client_absent_packages  = ['postfix','sendmail']
      $exim_client_stopped_services = ['postfix','sendmail' ]
      $exim_client_aliases          = ['root','elatov']
			
			if $::operatingsystemmajrelease >= 7 {
				### Server
				$exim_server_service_dir  	= '/usr/lib/systemd/system'
				$exim_server_config_file  	= 'exim.sysconf.systemd'
				$exim_server_service_file 	= 'exim.service'
				
				### Client
				$exim_client_service_dir  	= '/usr/lib/systemd/system'
				$exim_client_config_file  	= 'exim.conf.systemd'
				$exim_client_service_file 	= 'exim.service'
			}else{
				### Server
				$exim_server_service_dir		= '/etc/init.d'
				$exim_server_config_file		= 'exim.conf.init'
				$exim_server_service_file	= 'exim.init'
				
				### Client
				$exim_client_service_dir		= '/etc/init.d'
				$exim_client_config_file		= 'exim.conf.init'
				$exim_client_service_file	  = 'exim.init'
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
      $exim_client_settings_extra     = { 'stopped_services'  => ['sendmail'],
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
                                        }
      
    }
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$exim_server_default_settings = merge($exim_server_settings_all,$exim_server_settings_extra)
	$exim_client_default_settings = merge($exim_client_settings_all,$exim_client_settings_extra)
}