class zabbix::agent::install () {
  
  if !(defined(Class ["zabbix::server"])){
	  case $::operatingsystem {
	    /(?i:CentOS|fedora)/: { 
	#     include zabbix::repo::centos
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
  }
  ensure_packages($zabbix::agent::package_name,{ ensure  => 'present',})
  
  if $::operatingsystem =~ /(?i:CentOS|fedora)/ {
    exec {"${module_name}-systemd-tmpfiles":
        command => "/bin/systemd-tmpfiles --create zabbix.conf",
        require => Package ["$zabbix::agent::package_name"],
        unless => "/bin/test -d /var/run/zabbix",
    }  
  } 
}
