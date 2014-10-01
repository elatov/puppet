class zabbix::server::config () {
  
  file { "${zabbix::server::config_dir}/${zabbix::server::config_file}":
    ensure => 'present',
    content => template('zabbix/zabbix_server.conf.erb'),
  }

   if ($zabbix::server::enable_partition_mysql){
     
     ensure_packages('anacron',{ensure => 'present'})

     file {'/etc/cron.weekly/zab-part':
      ensure  => present,
      content => template('zabbix/zab-part.cron.erb'),
      mode    => '0755',
      require => Package['anacron'],
    }
   }
#  file { '/var/log/zabbix-server':
#    ensure => directory,
#    mode   => '0750',
#  }
}
