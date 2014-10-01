class zabbix::server::install () {
  mysql::db{ "${zabbix::server::server_zabbix_default_settings['dBName']}":
    user      => "${zabbix::server::server_zabbix_default_settings['dBUser']}",
    password  => "${zabbix::server::server_zabbix_default_settings['dBPassword']}",
    host      => "${zabbix::server::server_zabbix_default_settings['dBHost']}",
    grant     => "ALL",
    require => Class['mysql::server'],
  }

 case $::operatingsystem {
    /(?i:CentOS|fedora)/: { 
      include zabbix::repo::centos
    }
    /(?i:Debian)/: { 
      apt::source { 'zabbix':
        location   => "http://repo.zabbix.com/zabbix/${zabbix::server::version}/debian/",
        release    => 'wheezy',
        repos      => 'main',
        key        => '79EA5ED4',
        key_source => 'http://repo.zabbix.com/zabbix-official-repo.key',
        pin        => '510',
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }


  package { $zabbix::server::package_name:
    ensure       => installed,
#    responsefile => '/root/preseed/zabbix-server.preseed',
    require      => Mysql::Db['zabbix'],
  }
}
