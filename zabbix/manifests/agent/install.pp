class zabbix::agent::install () {
  
  if !(defined(Class["zabbix::server"])){
	  case $::operatingsystem {
	    /(?i:CentOS|fedora)/: {
				if (versioncmp($::operatingsystemmajrelease, '8') >= 0) {
					yumrepo { 'zabbix':
						name      => "zabbix",
						descr     => "Zabbix Official Repository - \$basearch",
						baseurl   => "http://repo.zabbix.com/zabbix/${zabbix::agent::settings['version']}/rhel/8/\$basearch/",
						enabled   => "1",
						gpgcheck  => "1",
	#          gpgkey    => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX",
					}
				} else {
					yumrepo { 'zabbix':
						name      => "zabbix",
						descr     => "Zabbix Official Repository - \$basearch",
						baseurl   => "http://repo.zabbix.com/zabbix/${zabbix::agent::settings['version']}/rhel/7/\$basearch/",
						enabled   => "1",
						gpgcheck  => "1",
	#          gpgkey    => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX",
					}
				} 
	    }
	    /(?i:Debian)/: { 
	      apt::source { 'zabbix':
	        location   => "http://repo.zabbix.com/zabbix/${zabbix::agent::settings['version']}/debian",
	        release    => 'buster',
	        repos      => 'main',
	        #key        => '79EA5ED4',
	        key        => 'FBABD5FB20255ECAB22EE194D13D58E479EA5ED4',
#	        key_source => 'http://repo.zabbix.com/zabbix-official-repo.key',
	        pin        => '510',
	      }
	    }
	    /(?i:FreeBSD)/:{
	    }
	    /(?i:OmniOS)/:{
      }
	    /(?i:Archlinux)/:{
      }
	    default: {
	      fail("Module ${module_name} is not supported on ${::operatingsystem}")
	    }
	  }
  }
  case $::operatingsystem {
    /(?i:OmniOS)/: {
	    ensure_resource(file,'/usr/local',{ensure => 'directory'})
	    
	    file { [$zabbix::agent::home_dir]:
	      ensure  => 'link',
	      require => File['/usr/local'],
	    }
	    
	    ensure_resource(file,'/usr/local/apps',{ensure => 'directory'})
	
	    file { $zabbix::agent::solaris_package_name:
	      ensure => 'present',
	      path   => "/usr/local/apps/${zabbix::agent::solaris_package_name}",
	      source => "puppet:///modules/zabbix/${zabbix::agent::solaris_package_name}",
	    }
	    
	    exec { "${module_name}-extract-zabbix":
	      path    => ['/usr/bin','/usr/sbin'],
	      command => "tar xvf /usr/local/apps/${zabbix::agent::solaris_package_name} -C ${zabbix::agent::home_dir}",
	      #creates => "${zabbix::agent::home_dir}/bin",
	      require => [File[$zabbix::agent::home_dir],File[$zabbix::agent::solaris_package_name]],
	      subscribe   => File["$zabbix::agent::solaris_package_name"],
        refreshonly => true,
	    }
	    
    }
	  /(?i:FreeBSD)/:{
	    ensure_packages($zabbix::agent::freebsd_package_name,{ ensure  => 'present',})
	  }
	  default: {
	    ensure_packages($zabbix::agent::package_name,{ ensure  => 'present',})
	  }
  }  

	case $::operatingsystem {
		/(?i:CentOS|fedora)/: {
			exec { "${module_name}-systemd-tmpfiles":
				command => "/bin/systemd-tmpfiles --create /usr/lib/tmpfiles.d/zabbix-agent.conf",
				require => Package[$zabbix::agent::package_name],
				unless  => "/bin/test -d /var/run/zabbix",
			}
		}
    /(?i:Archlinux)/: {
      exec { "${module_name}-systemd-tmpfiles":
				command => "/bin/systemd-tmpfiles --create /usr/lib/tmpfiles.d/zabbix-agent.conf",
				require => Package[$zabbix::agent::package_name],
				unless  => "/bin/test -d /var/lib/zabbix-agent",
			}
    }
	}
}
