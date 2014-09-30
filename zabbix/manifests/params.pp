class zabbix::params {
	case $::osfamily {
		'Debian': {
		    $server_zabbix_config_dir          = '/etc/zabbix'
		    $server_zabbix_config_file         = 'zabbix_server.conf'
		    $server_zabbix_package_name        = 'zabbix-server-mysql'
		    $server_zabbix_service_name        = 'zabbix-server'
		    $server_zabbix_settings            = '2.4'
		    $server_zabbix_default_settings    = { 'logFile'                => '/var/log/zabbix-server/zabbix_server.log',
		                                           'logFileSize'            => '1',
		                                           'pidFile'                => '/var/run/zabbix/zabbix_server.pid',
		                                           'dBHost'                 => 'localhost',
		                                           'dBName'                 => 'zabbix',
		                                           'dBUser'                 => 'zabbix',
		                                           'dBPassword'             => 'password',
		                                           'listenIp'               => $::ipaddress,
		                                           'housekeepingFrequency'  => '1',
		                                           'disableHousekeeping'    => '0',
		                                          }
		}
		'Redhat': {
		  $zabbix_server_config_dir          = '/etc/zabbix'
		  $zabbix_server_package_name        = 'zabbix-server-mysql'
		  $zabbix_server_service_name        = 'zabbix-server'
		  
		  if $::operatingsystemmajrelease >= 7 {
		    $zabbix_server_config_file       = 'zabbix-sysconf-systemd'
		    $zabbix_server_service_dir       = '/usr/lib/systemd/system'
		    $zabbix_server_service_file      = 'zabbix-server.service'
		  }else{
		    $zabbix_server_config_file       = 'zabbix-sysconf-init'
		    $zabbix_server_service_dir       = '/etc/init.d'
		    $zabbix_server_service_file      = 'zabbix-server.init'
		  }
		  
		}
	    
	    default: {
	      fail("${::module} is unsupported on ${::osfamily}")
	    }
	  }
}