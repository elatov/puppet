class zabbix::server::install () {
  
  if ($zabbix::server::enable_partition_mysql){
    
    file {'/usr/share/zabbix-server-mysql/zabbix-part.sql':
      ensure  => present,
      source  => "puppet:///modules/zabbix/zabbix-part.sql",
      require => Package[$zabbix::server::package_name],
    }
    
    exec {"${module_name}-concat-sql-files":
      command => 'cat /usr/share/zabbix-server-mysql/schema.sql /usr/share/zabbix-server-mysql/images.sql /usr/share/zabbix-server-mysql/data.sql /usr/share/zabbix-server-mysql/zabbix-part.sql > /usr/share/zabbix-server-mysql/all.sql',
      creates => '/usr/share/zabbix-server-mysql/all.sql',
      path    => ['/bin','usr/bin'],
      require => File['/usr/share/zabbix-server-mysql/zabbix-part.sql'],
    }
  }else{
    exec {"${module_name}-concat-sql-files":
      command => 'cat /usr/share/zabbix-server-mysql/schema.sql /usr/share/zabbix-server-mysql/images.sql /usr/share/zabbix-server-mysql/data.sql > /usr/share/zabbix-server-mysql/all.sql',
      creates => '/usr/share/zabbix-server-mysql/all.sql',
      path    => ['/bin','usr/bin'],
    }
  }
  file { "${zabbix::server::root_home}/.my.cnf":
      content => template('zabbix/my.cnf.pass.erb'),
      owner   => 'root',
      mode    => '0600',
    }
	mysql::db{ "${zabbix::server::settings['dBName']}":
		user      => "${zabbix::server::settings['dBUser']}",
		password  => "${zabbix::server::settings['dBPassword']}",
		host      => "${zabbix::server::settings['dBHost']}",
		grant     => "ALL",
		sql       => '/usr/share/zabbix-server-mysql/all.sql',
		require => [Exec["${module_name}-concat-sql-files"]]
	}
    
	case $::operatingsystem {
		/(?i:CentOS|fedora)/: { 
#		  include zabbix::repo::centos
      yumrepo { 'zabbix':
          name      => "Zabbix Official Repository - \$basearch",
          baseurl   => "http://repo.zabbix.com/zabbix/${zabbix::agent::settings['version']}/rhel/7/\$basearch/",
          enabled   => "1",
          gpgcheck  => "1",
#          gpgkey    => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX",
        } 
		}
		/(?i:Debian)/: { 
			apt::source { 'zabbix':
				location   => "http://repo.zabbix.com/zabbix/${zabbix::server::settings['version']}/debian",
				release    => 'stretch',
				repos      => 'main',
#				key        => '79EA5ED4',
#				key_source => 'http://repo.zabbix.com/zabbix-official-repo.key',
#				pin        => '510',
			}
		}
		default: {
		  fail("Module ${module_name} is not supported on ${::operatingsystem}")
		}
	}

  if ($zabbix::server::enable_server) {
    package { $zabbix::server::package_name:
      ensure => installed,
      #    responsefile => '/root/preseed/zabbix-server.preseed',
      #    require      => Mysql::Db['zabbix'],
    }
  }
  
  if ($zabbix::server::enable_web){
		package { $zabbix::server::web_package_name:
			ensure       => installed,
			# require      => Package[$zabbix::server::package_name],
		}
  }
}
