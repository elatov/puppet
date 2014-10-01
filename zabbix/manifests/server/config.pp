class zabbix::server::config () {
  
  file { "${zabbix::server::config_dir}/${zabbix::server::config_file}":
    ensure => 'present',
    content => template('zabbix/zabbix_server.conf.erb'),
  }

#  file { '/var/log/zabbix-server':
#    ensure => directory,
#    mode   => '0750',
#  }
}
