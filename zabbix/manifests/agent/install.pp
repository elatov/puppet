class zabbix::agent::install () {
  package { $zabbix::agent::params::package_name:
    ensure  => installed,
  }
  
  if $::operatingsystem =~ /(?i:CentOS|fedora)/ {
    exec {'systemd-tmpfiles':
        command => "/bin/systemd-tmpfiles --create zabbix.conf",
        require => Package ["$zabbix::agent::params::package_name"],
        unless => "/bin/test -d /var/run/zabbix",
    }  
  } 
}
