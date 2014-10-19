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
  
  if ($::osfamily == 'Solaris'){
   
    file { '/var/adm/mail.log':
      ensure => 'present',
    }->
    file_line { "enable_mail_in_${rsyslog::conf_file}":
      path  => $rsyslog::conf_file,
      match => "^mail.debug*",
      line  => "mail.debug;mail.err;mail.alert;mail.warning;mail.info;mail.notice;mail.emerg\t/var/adm/mail.log",
    }->
    file_line { "enable_mail-crit_in_${rsyslog::conf_file}":
      path  => $rsyslog::conf_file,
      match => "*.daemon.*/var/adm/messages$",
      line  => "*.err;kern.debug;daemon.notice\t/var/adm/messages",
    }->
    file_line { "enable_smartd_in_${rsyslog::conf_file}":
      path => $rsyslog::conf_file,
      line => "local3.warning;local3.err;local3.alert;local3.debug;local3.info;local3.notice;local3.debug\t/var/adm/smartd.log",
    }-> 
    file { '/var/adm/auth.log':
      ensure => 'present',
    }->
    file_line { "enable_auth_in_${rsyslog::conf_file}":
      path => $rsyslog::conf_file,
      line => "auth.warning;auth.err;auth.alert;auth.debug;auth.info;auth.notice;auth.debug\t/var/adm/auth.log",
    }-> 
    file_line { "enable_remote_in_${rsyslog::conf_file}":
      path => $rsyslog::conf_file,
      line => "*.emerg;*.alert;*.crit;*.err;*.warning;*.notice;*.info;*.debug\t@${rsyslog::settings['server']}",
    }
  }
}