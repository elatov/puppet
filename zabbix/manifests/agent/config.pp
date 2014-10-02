class zabbix::agent::config () {
  
	file { $zabbix::agent::custom_scripts_dir:
	 ensure => directory,
	}

  file { $zabbix::agent::agentd_conf_dir:
    ensure => directory,
  }

  if($zabbix::agent::settings['smart']) {
    # Add custom scripts for smart status
    file { "${zabbix::agent::custom_scripts_dir}/get_smart_value.bash":
      source  => 'puppet:///modules/zabbix/get_smart_value.bash',
      require => File[$zabbix::agent::custom_scripts_dir],
    }

    # rules for user parameters
    file { "${zabbix::agent::agentd_conf_dir}/smart.conf":
      source  => 'puppet:///modules/zabbix/smart.conf',
      require => File[$zabbix::agent::agentd_conf_dir],
      mode => '644',
    }

    # sudoers for smartctl
    sudo::conf { "${module_name}-agentd-smartctl":
      priority => 20,
      content  => "zabbix ALL=(ALL) NOPASSWD: /usr/sbin/smartctl",
    }
  }

  if($zabbix::agent::settings['raid']){
    # Add custom script
    file { "${zabbix::agent::custom_scripts_dir}/md-discovery.sh":
      source  => 'puppet:///modules/zabbix/md-discovery.sh',
      require => File[$zabbix::agent::custom_scripts_dir],
    }
    
    # rules for user parameters
    file { "${zabbix::agent::agentd_conf_dir}/raid.conf":
      source  => 'puppet:///modules/zabbix/raid.conf',
      require => File[$zabbix::agent::agentd_conf_dir],
    }

    # sudoers for mdadm
    sudo::conf { "${module_name}-agentd-mdadm":
      priority => 20,
      content  => "zabbix ALL=(ALL) NOPASSWD: /sbin/mdadm --detail *\n",
    }
  }

  if($zabbix::agent::settings['disk_perf']){
    # Add custom script
    file { "${zabbix::agent::custom_scripts_dir}/discover_disk.pl":
      source  => 'puppet:///modules/zabbix/discover_disk.pl',
      require => File[$zabbix::agent::custom_scripts_dir],
    }
     
    # rules for user parameters
    file { "${zabbix::agent::agentd_conf_dir}/disk_perf.conf":
      source  => 'puppet:///modules/zabbix/disk_perf.conf',
      require => File[$zabbix::agent::agentd_conf_dir],
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
