class zabbix::agent::config () {
  File {
    ensure => present,
    owner  => 'zabbix',
    group  => 'zabbix',
    mode   => '0640',
    notify => Class['zabbix::agent::service'],
  }

  case $::operatingsystem {
    /(?i:CentOS|fedora)/: { 
      $config_path = "/etc/zabbix_agentd.conf"
    }
    /(?i:Debian)/: { 
      $config_path = "/etc/zabbix/zabbix_agentd.conf"
    }
    default: {
      $config_path = "/etc/zabbix/zabbix_agentd.conf"
    }
  }
  
  file { "$config_path":
    content => template('zabbix/zabbix_agentd.conf.erb'),
  }
}
