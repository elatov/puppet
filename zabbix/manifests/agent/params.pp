class zabbix::agent::params () {
  case $::operatingsystem {
    /(?i:Ubuntu|Debian|fedora)/: {
      $service_name   = 'zabbix-agent'
      $package_name   = 'zabbix-agent'
    }
    /(?i:CentOS)/: {
      $service_name   = 'zabbix-agent'
      $package_name   = 'zabbix22-agent'
     }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}