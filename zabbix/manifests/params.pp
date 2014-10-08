class zabbix::params {
	case $::osfamily {
		'Debian': {
		    ### Server
		    $server_zabbix_config_dir             = '/etc/zabbix'
		    $server_zabbix_config_file            = 'zabbix_server.conf'
		    $server_zabbix_package_name           = 'zabbix-server-mysql'
		    $server_zabbix_web_package_name       = 'zabbix-frontend-php'
		    $server_zabbix_service_name           = 'zabbix-server'
		    $server_zabbix_version                = '2.4'
		    $server_zabbix_enable_partition_mysql = true
		    $server_zabbix_enable_web             = true
		    $server_zabbix_default_settings       = { 'logFile'                => '/var/log/zabbix-server/zabbix_server.log',
		                                              'logFileSize'            => '1',
		                                              'pidFile'                => '/var/run/zabbix/zabbix_server.pid',
		                                              'dBHost'                 => 'localhost',
		                                              'dBName'                 => 'zabbix',
		                                              'dBUser'                 => 'zabbix',
		                                              'dBPassword'             => 'password',
		                                              'startVMwareCollectors'  => '1',
		                                              'listenIp'               => $::ipaddress,
		                                            }
        ### Client/Agent
        $agent_zabbix_config_dir             = '/etc/zabbix'
        $agent_zabbix_custom_scripts_dir     = "${agent_zabbix_config_dir}/custom-scripts.d"
        $agent_zabbix_agentd_conf_dir        = "${agent_zabbix_config_dir}/zabbix_agentd.d"
        $agent_zabbix_config_file            = 'zabbix_agentd.conf'
        $agent_zabbix_package_name           = 'zabbix-agent'
        $agent_zabbix_service_name           = 'zabbix-agent'
        $agent_zabbix_version                = '2.4'
        
        $agent_zabbix_default_settings       = { 'logFile'                => '/var/log/zabbix/zabbix_agentd.log',
                                                 'logFileSize'            => '1',
                                                 'pidFile'                => '/var/run/zabbix/zabbix_agentd.pid',
                                                 'startagents'            => '1',
                                                 'server'                 => '127.0.0.1',
                                                 'hostname'               => $::fqdn,
                                                 'listenIp'               => $::ipaddress,
                                                 'smart'                  => false,
                                                 'disk_perf'              => false,
                                                }
		}
		'FreeBSD': {
			$zabbix_server_config_dir          = '/usr/local/etc/zabbix22'
			$zabbix_server_package_name        = 'zabbix22-server'
			$zabbix_server_service_name        = 'zabbix-server'
			
			### Client/Agent
			$agent_zabbix_config_dir             = '/usr/local/etc/zabbix22'
			$agent_zabbix_custom_scripts_dir     = "${agent_zabbix_config_dir}/custom-scripts.d"
      $agent_zabbix_agentd_conf_dir        = "${agent_zabbix_config_dir}/zabbix_agentd.conf.d"
			$agent_zabbix_config_file            = 'zabbix_agentd.conf'
			$agent_zabbix_package_name           = 'zabbix22-agent'
			$agent_zabbix_service_name           = 'zabbix_agentd'
			$agent_zabbix_version                = '2.2'
			$agent_zabbix_default_settings       = { 'logFile'                => '/var/log/zabbix/zabbix_agentd.log',
                                                 'logFileSize'            => '1',
                                                 'pidFile'                => '/var/run/zabbix/zabbix_agentd.pid',
                                                 'startagents'            => '1',
                                                 'server'                 => '127.0.0.1',
                                                 'hostname'               => $::fqdn,
                                                 'listenIp'               => $::ipaddress,
                                                 'smart'                  => false,
                                                 'disk_perf'              => false,
                                                }
			
		}
	    'Redhat': {
      $zabbix_server_config_dir          = '/etc/zabbix'
      $zabbix_server_package_name        = 'zabbix-server-mysql'
      $zabbix_server_service_name        = 'zabbix-server'
      
      ### Client/Agent
      $agent_zabbix_config_dir             = '/etc/zabbix'
      $agent_zabbix_custom_scripts_dir     = "${agent_zabbix_config_dir}/custom-scripts.d"
      $agent_zabbix_agentd_conf_dir        = "${agent_zabbix_config_dir}/zabbix_agentd.d"
      $agent_zabbix_config_file            = 'zabbix_agentd.conf'
      $agent_zabbix_package_name           = 'zabbix22-agent'
      $agent_zabbix_service_name           = 'zabbix-agent'
      $agent_zabbix_version                = '2.2'
      $agent_zabbix_default_settings       = { 'logFile'                => '/var/log/zabbix/zabbix_agentd.log',
                                                 'logFileSize'            => '1',
                                                 'pidFile'                => '/var/run/zabbix/zabbix_agentd.pid',
                                                 'startagents'            => '1',
                                                 'server'                 => '127.0.0.1',
                                                 'hostname'               => $::fqdn,
                                                 'listenIp'               => $::ipaddress,
                                                 'smart'                  => false,
                                                 'disk_perf'              => false,
                                                }
      
    }
	    default: {
	      fail("${::module} is unsupported on ${::osfamily}")
	    }
	  }
}