# == Class smartd::params
#
# This class is meant to be called from smartd
# It sets variables according to platform
#
class smartd::params {

	$smartd_default_settings_all	=	{ 'devicescan' 	        => true,
										                'devicescan_options'	=> '-H -n standby,10,q -W 1' ,
										                'mailto'              => 'root',
										              }
	case $::osfamily {
		'Debian': {
			$smartd_package_name		     = 'smartd'
			$smartd_service_name		     = 'smartd'
			$smartd_config_dir			     = '/etc/default'
			$smartd_service_dir			     = '/etc/init.d'
			$smartd_config_file			     = 'smartd.sysconf.init'
			$smartd_service_file		     = 'smartd.init'
			$smartd_default_settings_os  = {}
		}
		'RedHat': {
			$smartd_package_name		     = 'smartd'
			$smartd_service_name		     = 'smartd'
			$smartd_config_dir			     = '/etc/sysconfig'
			$smartd_default_settings_os  = {}
			
			if $::operatingsystemmajrelease >= 7 {
				$smartd_service_dir  	     = '/usr/lib/systemd/system'
				$smartd_config_file  	     = 'smartd.sysconf.systemd'
				$smartd_service_file 	     = 'smartd.service'
			}else{
				$smartd_service_dir		     = '/etc/init.d'
				$smartd_config_file		     = 'smartd.sysconf.init'
				$smartd_service_file	     = 'smartd.init'
			}
		}
		'Solaris': {
		  ### Package
      $smartd_package_name         = 'smartmontools'
     
      ### Service
      $smartd_service_name         = 'smartd'
     
      #### Dir
      $smartd_config_dir           = '/opt/csd/etc'
      $smartd_service_dir          = '/lib/svc/method'
      $smartd_manifest_dir         = '/var/svc/manifest/application/'

      ### Config Files
      $smartd_config_file          = 'smartd.conf'
      $smartd_service_file         = 'smartd.smf'
      $smartd_manifest_file        = 'smartd.xml'
      
      ### Settings
      $smartd_default_settings_os  = { 'devicescan'   => false }
    }
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$smartd_default_settings = merge($smartd_default_settings_all,$smartd_default_settings_os)
}
