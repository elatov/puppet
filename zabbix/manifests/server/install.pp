class zabbix::server::install () {
  
  if ($zabbix::server::enable_partition_mysql){
    file {'/tmp/zabbix-part.sql':
      ensure => present,
      source => "puppet:///modules/zabbix/zabbix-part.sql",
    }
    mysql::db{ "${zabbix::server::server_zabbix_default_settings['dBName']}":
      user      => "${zabbix::server::server_zabbix_default_settings['dBUser']}",
      password  => "${zabbix::server::server_zabbix_default_settings['dBPassword']}",
      host      => "${zabbix::server::server_zabbix_default_settings['dBHost']}",
      grant     => "ALL",
      sql       => '/tmp/zabbix-part.sql',
      require => [Class['mysql::server'],File['/tmp/zabbix-part.sql']]
    }
  }else{
    exec {'${module_name}-concat-sql-files':
      command => 'cat /usr/share/zabbix-server-mysql/images.sql /usr/share/zabbix-server-mysql/schema.sql /usr/share/zabbix-server-mysql/data.sql > /usr/share/zabbix-server-mysql/all.sql',
      creates => '/usr/share/zabbix-server-mysql/all.sql',
      
    }
	  mysql::db{ "${zabbix::server::server_zabbix_default_settings['dBName']}":
	    user      => "${zabbix::server::server_zabbix_default_settings['dBUser']}",
	    password  => "${zabbix::server::server_zabbix_default_settings['dBPassword']}",
	    host      => "${zabbix::server::server_zabbix_default_settings['dBHost']}",
	    grant     => "ALL",
	    sql       => '/usr/share/zabbix-server-mysql/images.sql',
	    require => Class['mysql::server'],
	  }
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
  
  if ($zabbix::server::enable_web){
		package { $zabbix::server::web_package_name:
			ensure       => installed,
			require      => Package [ $zabbix::server::package_name],
		}
  }
}
