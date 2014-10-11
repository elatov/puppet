class rsyslog::config {
  if ($rsyslog::rsyslog_d != undef){
	  file { $rsyslog::rsyslog_d:
	    ensure  => directory,
	    owner   => 'root',
	  }
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
      source => "puppet:///modules/rsyslog/iptables.conf",
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
  
  if ($::osfamily == 'FreeBSD'){
    file_line { "syslogd_e_in_${rsyslog::rc_conf}":
      path => $rsyslog::rc_conf,
      line => "syslogd_enable=\"YES\"",
    } 
		file_line { "syslogd_f_in_${rsyslog::rc_conf}":
			path => $rsyslog::rc_conf,
			line => "syslogd_flags=\"-4 -s -v -v\"",
		} 
  
    file_line { "enable_remote_in_${rsyslog::conf_file}":
      path => $rsyslog::conf_file,
      line => "*.*\t@${rsyslog::settings['server']}",
    } 
  }
}