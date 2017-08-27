class zabbix::server::service () {
  service { $zabbix::server::service_name:
    ensure     => stopped,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}

