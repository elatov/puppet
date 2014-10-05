class rsyslog::config {
  file { $rsyslog::rsyslog_d:
    ensure  => directory,
    owner   => 'root',
  }
  
  if ($rsyslog::remote_conf){
    file {"${rsyslog::rsyslog_d}/remote.conf":
      ensure => "present",
      content => template("rsyslog/remote.conf.erb"),
      require => File[$rsyslog::rsyslog_d],
    }
  }
  
  if ($rsyslog::iptables_conf){
    file {"${rsyslog::rsyslog_d}/iptables.conf":
      ensure => "present",
      source => "puppet:///modules/my_rsyslog/iptables.conf",
      require => File[$rsyslog::rsyslog_d],
    }
		logrotate::rule { 'iptables-log':
			path         => '/var/log/iptables.log',
			rotate       => 5,
			rotate_every => 'week',
			ifempty => false,
			compress => true,
			missingok => true,
		}
  }
}