class zabbix::agent::install () {
  
  if !(defined(Class ["zabbix::server"])){
	  case $::operatingsystem {
	    /(?i:CentOS|fedora)/: { 
	    }
	    /(?i:Debian)/: { 
	      apt::source { 'zabbix':
	        location   => "http://repo.zabbix.com/zabbix/${zabbix::agent::settings['version']}/debian/",
	        release    => 'wheezy',
	        repos      => 'main',
	        key        => '79EA5ED4',
	        key_source => 'http://repo.zabbix.com/zabbix-official-repo.key',
	        pin        => '510',
	      }
	    }
	    /(?i:FreeBSD)/:{
	    }
	    /(?i:OmniOS)/:{
      }
	    
	    default: {
	      fail("Module ${module_name} is not supported on ${::operatingsystem}")
	    }
	  }
  }
  if ($::operatingsystem == 'OmniOS'){
    ensure_resource(file,'/usr/local',{ensure => 'directory'})
    
    file { [$zabbix::agent::home_dir]:
      ensure  => 'directory',
      require => File['/usr/local'],
    }
    
    ensure_resource(file,'/usr/local/apps',{ensure => 'directory'})

    file { $zabbix::agent::package_name:
      ensure => 'present',
      path   => "/usr/local/apps/${zabbix::agent::package_name}",
      source => "puppet:///modules/zabbix/${zabbix::agent::package_name}",
    }
    
    exec { "${module_name}-extract-zabbix":
      path    => ['/usr/bin','/usr/sbin'],
      command => "tar xvf /usr/local/apps/${zabbix::agent::package_name} -C ${zabbix::agent::home_dir}",
      creates => "${zabbix::agent::home_dir}/bin",
      require => [File[$zabbix::agent::home_dir],File[$zabbix::agent::package_name]],
    }
  }else{
    ensure_packages($zabbix::agent::package_name,{ ensure  => 'present',})
  }  
  
  if $::operatingsystem =~ /(?i:CentOS|fedora)/ {
    exec {"${module_name}-systemd-tmpfiles":
        command => "/bin/systemd-tmpfiles --create zabbix.conf",
        require => Package ["$zabbix::agent::package_name"],
        unless => "/bin/test -d /var/run/zabbix",
    }  
  } 
}
