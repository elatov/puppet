class rsyslog::params {
  
  $rsyslog_default_settings = {server => '192.168.2.1'}
  
  case $::operatingsystem {
    /(?i:CentOS|fedora)/: { 
        $rsyslog_package_name   = 'rsyslog'
        $rsyslog_d              = '/etc/rsyslog.d'
        $rsyslog_service_name   = 'rsyslog'
        $rsyslog_remote_conf    = true
        $rsyslog_iptables_conf  = true
    }
    /(?i:Debian|Ubuntu)/: { 
				$rsyslog_package_name   = 'rsyslog'
        $rsyslog_d              = '/etc/rsyslog.d'
        $rsyslog_service_name   = 'rsyslog'
        $rsyslog_remote_conf    = true
        $rsyslog_iptables_conf  = true
    }
    /(?i:FreeBSD)/: { 
        $rsyslog_rc_conf        = '/etc/rc.conf'
        $rsyslog_conf_file      = '/etc/syslog.conf'
        $rsyslog_service_name   = 'syslogd'
        $rsyslog_remote_conf    = false
        $rsyslog_iptables_conf  = false
    }
    /(?i:OmniOS)/: { 
        $rsyslog_conf_file      = '/etc/syslog.conf'
        $rsyslog_service_name   = 'system-log'
        $rsyslog_remote_conf    = false
        $rsyslog_iptables_conf  = false
    }
    default: {
				$rsyslog_package_name = 'rsyslog'
        $rsyslog_d = '/etc/rsyslog.d'
        $rsyslog_service_name = 'rsyslog'
        $rsyslog_remote_conf = true
    }
  }
}