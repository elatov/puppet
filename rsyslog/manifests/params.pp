class rsyslog::params {
  
  $rsyslog_default_settings = {server => '192.168.2.1'}
  
  case $::operatingsystem {
    /(?i:CentOS|fedora)/: { 
        $rsyslog_package_name = 'rsyslog'
        $rsyslog_d = '/etc/rsyslog.d'
        $rsyslog_service_name = 'rsyslog'
        $rsyslog_remote_conf = true
        $rsyslog_iptables_conf = true
    }
    /(?i:Debian|Ubuntu)/: { 
				$rsyslog_package_name = 'rsyslog'
        $rsyslog_d = '/etc/rsyslog.d'
        $rsyslog_service_name = 'rsyslog'
        $rsyslog_remote_conf = true
        $rsyslog_iptables_conf = true
    }
    default: {
				$rsyslog_package_name = 'rsyslog'
        $rsyslog_d = '/etc/rsyslog.d'
        $rsyslog_service_name = 'rsyslog'
        $rsyslog_remote_conf = true
    }
  }
}