class zabbix::agent::config () {
  
  ensure_resource (file,$zabbix::agent::config_dir,{ensure => 'directory'})
  
	file { $zabbix::agent::custom_scripts_dir:
		ensure  => directory,
		require => File[$zabbix::agent::config_dir],
	}

	file { $zabbix::agent::custom_conf_dir:
		ensure => directory,
		require => File[$zabbix::agent::config_dir],
	}
  
  if ($::osfamily == 'FreeBSD'){
    file {'/var/log/zabbix':
      ensure => 'directory',
      owner  => 'zabbix',
      group  => 'zabbix',
    }

    file {'/var/run/zabbix':
      ensure => 'directory',
      owner  => 'zabbix',
      group  => 'zabbix',
    }
    newsyslog {'/var/log/zabbix/zabbix_agentd.log':
      owner   => 'zabbix',
      group   => 'zabbix',
      mode    => '644',
      keep    => '5',
      size    => '*',
      when    => '@T00',
      flags   => 'JC',
      pidfile => '/var/run/zabbix/zabbix.pid'
    }
  }
  
  if ($::osfamily == 'Solaris'){
    file {'/var/adm/zabbix':
      ensure => 'directory',
    }

    logadm { "${zabbix::agent::settings['logFile']}":
      count          => '5',
      copy_truncate  => true,
    }
    
    file { $zabbix::agent::service_file:
      ensure  => "present",
      path    => "${zabbix::agent::service_dir}/svc-zabbix-agent",
      mode    => '0555',
      owner   => 'root',
      group   => 'bin',
      content => template("zabbix/${zabbix::agent::service_file}.erb"),
    }->
    file { $zabbix::agent::manifest_file: 
      ensure  => "present",
      path    => "${zabbix::agent::manifest_dir}/${zabbix::agent::manifest_file}",
      mode    => '0444',
      owner   => 'root',
      group   => 'sys',
      source => "puppet:///modules/zabbix/${zabbix::agent::manifest_file}",
    }~>
    exec { "${module_name}-import-svc":
      path        => ["/sbin","/usr/sbin"],
      command     => "svccfg import ${zabbix::agent::manifest_dir}/${zabbix::agent::manifest_file}",
      refreshonly => true,
    }
  }
  if($zabbix::agent::settings['smart']) {
    # Add custom scripts for smart status
    file { "${zabbix::agent::custom_scripts_dir}/get_smart_value.bash":
      source  => 'puppet:///modules/zabbix/get_smart_value.bash',
      require => File[$zabbix::agent::custom_scripts_dir],
    }

    # rules for user parameters
    if ($::osfamily == 'Solaris'){
      file { "${zabbix::agent::custom_conf_dir}/smart-sunos.conf":
        source  => 'puppet:///modules/zabbix/smart.conf',
        require => File[$zabbix::agent::custom_conf_dir],
        mode => '644',
      }
    }else{
	    file { "${zabbix::agent::custom_conf_dir}/smart.conf":
	      source  => 'puppet:///modules/zabbix/smart.conf',
	      require => File[$zabbix::agent::custom_conf_dir],
	      mode => '644',
	    }
	    
      # sudoers for smartctl
	    sudo::conf { "${module_name}-agentd-smartctl":
        priority => 20,
        content  => "zabbix ALL=(ALL) NOPASSWD: /usr/sbin/smartctl",
      }
    }
  }

  if($zabbix::agent::settings['raid']){
    # Add custom script
    file { "${zabbix::agent::custom_scripts_dir}/md-discovery.sh":
      source  => 'puppet:///modules/zabbix/md-discovery.sh',
      require => File[$zabbix::agent::custom_scripts_dir],
    }
    
    # rules for user parameters
    file { "${zabbix::agent::custom_conf_dir}/raid.conf":
      source  => 'puppet:///modules/zabbix/raid.conf',
      require => File[$zabbix::agent::custom_conf_dir],
    }

    # sudoers for mdadm
    if ($::operatingsystem != 'OmniOS'){
	    sudo::conf { "${module_name}-agentd-mdadm":
	      priority => 20,
	      content  => "zabbix ALL=(ALL) NOPASSWD: /sbin/mdadm --detail *\n",
	    }
    }
  }

  if($zabbix::agent::settings['disk_perf']){
    if ($::osfamily == 'FreeBSD'){
      # rules for user parameters
      file { "${zabbix::agent::custom_conf_dir}/disk_perf.conf":
        source  => 'puppet:///modules/zabbix/disk_perf-freebsd.conf',
        require => File[$zabbix::agent::custom_conf_dir],
        mode => "644",
      }
      
      cron {"zabbix-disk-perf-freebsd":
        command => "/usr/sbin/iostat -x -t da 1 2 > /tmp/iostat.txt",
        user => "zabbix",
      }
    }elsif  ($::osfamily == 'Solaris'){
      # rules for user parameters
      file { "${zabbix::agent::custom_conf_dir}/disk_perf.conf":
        source  => 'puppet:///modules/zabbix/disk_perf-sunos.conf',
        require => File[$zabbix::agent::custom_conf_dir],
        mode => "644",
      }
      
      cron {"zabbix-disk-perf-sunos":
        command => "/usr/bin/iostat -xn 1 2 > /tmp/iostat.txt",
      }
    } else {
	    # Add custom script
	    file { "${zabbix::agent::custom_scripts_dir}/discover_disk.pl":
	      source  => 'puppet:///modules/zabbix/discover_disk.pl',
	      require => File[$zabbix::agent::custom_scripts_dir],
	    }
	     
	    # rules for user parameters
	    file { "${zabbix::agent::custom_conf_dir}/disk_perf.conf":
	      source  => 'puppet:///modules/zabbix/disk_perf.conf',
	      require => File[$zabbix::agent::custom_conf_dir],
	      mode => "644",
	    }
	
	    # systat
	    ensure_packages("sysstat", {ensure => "present"})
	    
	    cron {"zabbix-disk-perf":
	      command => "/usr/bin/iostat -x 1 2 > /tmp/iostat.txt",
	      user => "zabbix",
	      require => Package ["sysstat"],
	    }
    }
  }
  
  if($zabbix::agent::settings['mysql']){
    file { '/etc/zabbix/zabbix_agentd.conf.d/mysql.conf':
      source  => 'puppet:///modules/zabbix/mysql.conf',
      require => File['/etc/zabbix/zabbix_agentd.conf.d/'],
    }
  }

  if($zabbix::agent::settings['ups']){
    file { '/etc/zabbix/zabbix_agentd.conf.d/ups.conf':
      source  => 'puppet:///modules/zabbix/ups.conf',
      require => File['/etc/zabbix/zabbix_agentd.conf.d/'],
    }
  }
  
  case $::operatingsystem {
    /(?i:CentOS|fedora)/: { 
      $config_path = "/etc/${zabbix::agent::config_file}"
    }
    /(?i:Debian)/: { 
      $config_path = "${zabbix::agent::config_dir}/${zabbix::agent::config_file}"
    }
    default: {
      $config_path = "${zabbix::agent::config_dir}/${zabbix::agent::config_file}"
    }
  }
  
  file { "$config_path":
    ensure  => 'present',
    content => template('zabbix/zabbix_agentd.conf.erb'),
  }
}
