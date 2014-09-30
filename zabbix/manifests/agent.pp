class zabbix::agent (
  $hostname,
  $pidFile      = '/var/run/zabbix/zabbix_agentd.pid',
  $logFile      = '/var/log/zabbix/zabbix_agentd.log',
  $logFileSize  = undef,
  $debugLevel   = undef,
  $server       = ['127.0.0.1'],
  $serverActive = undef,
  $raid         = false,
  $mysql        = false,
  $smart        = false,
  $disk_perf    = false,
  $ups          = false,
  $startagents  = '1',
) {


  if(! defined(Class['zabbix']))
  {
    class{ 'zabbix': }
    Class['zabbix'] -> Class['zabbix::agent']
  }

  # declare all parameterized classes
  class { 'zabbix::agent::params': }
  class { 'zabbix::agent::install': }
  class { 'zabbix::agent::config': }
  class { 'zabbix::agent::service': }

  File {
    ensure  => present,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    notify  => Service[$zabbix::agent::params::service_name],
    require => Package[$zabbix::agent::params::package_name],
  }

  file { '/etc/zabbix/custom-scripts.d/':
    ensure => directory,
  }

  file { '/etc/zabbix/zabbix_agentd.conf.d/':
    ensure => directory,
  }

  if($smart)
  {
    # Add custom scripts for smart status
    file { '/etc/zabbix/custom-scripts.d/get_smart_value.bash':
      source  => 'puppet:///modules/zabbix/get_smart_value.bash',
      require => File['/etc/zabbix/custom-scripts.d/'],
    }

    # Push rules to user paremters
    file { '/etc/zabbix/zabbix_agentd.conf.d/smart.conf':
      source  => 'puppet:///modules/zabbix/smart.conf',
      require => File['/etc/zabbix/zabbix_agentd.conf.d/'],
      mode => '644',
    }

    # sudoers for puppet smartctl
    sudo::conf { 'zabbix-smartctl':
      priority => 20,
      content  => "zabbix ALL=(ALL) NOPASSWD: /usr/sbin/smartctl",
    }
  }

  if($raid)
  {
    # Add custom script
    file { '/etc/zabbix/custom-scripts.d/md-discovery.sh':
      source  => 'puppet:///modules/zabbix/md-discovery.sh',
      require => File['/etc/zabbix/custom-scripts.d/'],
    }

    file { '/etc/zabbix/zabbix_agentd.conf.d/raid.conf':
      source  => 'puppet:///modules/zabbix/raid.conf',
      require => File['/etc/zabbix/zabbix_agentd.conf.d/'],
    }

    # sudoers for puppet mdadm
    sudo::conf { 'zabbix-mdadm':
      priority => 20,
      content  => "zabbix ALL=(ALL) NOPASSWD: /sbin/mdadm --detail *\n",
    }
  }
  else
  {
  }

  if($disk_perf)
  {
    # Add custom script
    file { '/etc/zabbix/custom-scripts.d/discover_disk.pl':
      source  => 'puppet:///modules/zabbix/discover_disk.pl',
      require => File['/etc/zabbix/custom-scripts.d/'],
    }

    file { '/etc/zabbix/zabbix_agentd.conf.d/disk_perf.conf':
      source  => 'puppet:///modules/zabbix/disk_perf.conf',
      require => File['/etc/zabbix/zabbix_agentd.conf.d/'],
      mode => "644",
    }

    # cron
    package {"sysstat":
      ensure => "present",
    }
    
    cron {"zabbix-disk-perf":
	    command => "/usr/bin/iostat -x 1 2 > /tmp/iostat.txt",
	    user => "zabbix",
	    require => Package ["sysstat"],
    }
  }
  
  if($mysql)
  {
    file { '/etc/zabbix/zabbix_agentd.conf.d/mysql.conf':
      source  => 'puppet:///modules/zabbix/mysql.conf',
      require => File['/etc/zabbix/zabbix_agentd.conf.d/'],
    }
  }

  if($ups)
  {
    file { '/etc/zabbix/zabbix_agentd.conf.d/ups.conf':
      source  => 'puppet:///modules/zabbix/ups.conf',
      require => File['/etc/zabbix/zabbix_agentd.conf.d/'],
    }
  }

  # declare relationships
  Class['sudo'] ->
  Class['zabbix::agent::params'] ->
  Class['zabbix::agent::install'] ->
  Class['zabbix::agent::config'] ->
  Class['zabbix::agent::service']
}
