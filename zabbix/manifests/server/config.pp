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
   
   if ($zabbix::server::enable_web){
    augeas { "${module_name}-modify-php-timezone":
      lens       => 'Httpd.lns',
      incl       => '/etc/zabbix/apache.conf',
      context    => '/files/etc/zabbix/apache.conf',
      changes    => ["set Directory[arg = '\"/usr/share/zabbix\"']/directive[last()+1] 'php_value'",
                     "set Directory[arg = '\"/usr/share/zabbix\"']/directive[last()]/arg[1] 'date.timezone'",
                     "set Directory[arg = '\"/usr/share/zabbix\"']/directive[last()]/arg[2] 'America/Denver'",],
      onlyif     => "match Directory/directive[arg = 'America/Denver'] size < 1 ",
      require => Package["$zabbix::server::web_package_name"],
#      notify     => Service['httpd']
    }
    
    file {'/etc/zabbix/web/zabbix.conf.php':
      ensure  => present,
      content => template('zabbix/zabbix.conf.php.erb'),
      require => Package["$zabbix::server::web_package_name"],
#      notify     => Service['httpd']
    }
  }
#  file { '/var/log/zabbix-server':
#    ensure => directory,
#    mode   => '0750',
#  }
}
