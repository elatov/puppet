class rsyslog::service {
  service { $rsyslog::service_name:
    ensure     => running,
    enable     => true,
  }
}
