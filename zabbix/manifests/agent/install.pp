class zabbix::agent::install () {
  
  ensure_packages($zabbix::agent::package_name,{ ensure  => 'present',})
  
  if $::operatingsystem =~ /(?i:CentOS|fedora)/ {
    exec {"${module_name}-systemd-tmpfiles":
        command => "/bin/systemd-tmpfiles --create zabbix.conf",
        require => Package ["$zabbix::agent::package_name"],
        unless => "/bin/test -d /var/run/zabbix",
    }  
  } 
}
