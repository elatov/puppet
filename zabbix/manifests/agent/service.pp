class zabbix::agent::service () {
  service { $zabbix::agent::service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}

