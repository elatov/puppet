class zabbix::agent::service () {
	service { $zabbix::agent::service_name:
		ensure     => stopped,
		hasstatus  => true,
		hasrestart => true,
		enable     => true,
	}
}

