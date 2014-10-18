# == Class smartd::config
#
# This class is called from smartd
#
class smartd::config {

  if $smartd::service_file =~ /(?i:service)/ {
    file { $smartd::service_file:
      ensure  => "present",
      path    => "${smartd::service_dir}/${smartd::service_file}",
      mode    => '0644',
      content => template("smartd/${smartd::service_file}.erb"),
    }~>
    exec { "${module_name}-reload-systemd":
      path    		=> ["/bin","/usr/bin"],
      command 		=> "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $smartd::service_file =~ /(?i:.init)/ {
    file { $smartd::service_file:
      ensure  => 'present',
      path    => "${smartd::service_dir}/smartd",
      mode    => '0755',
      content => "puppet:///modules/smartd/${smartd::service_file}",
    }
  }
  
  if $smartd::service_file =~ /(?i:.smf)/ {
    file { $smartd::service_file:
      ensure  => "present",
      path    => "${smartd::service_dir}/svc-smartd",
      mode    => '0555',
      owner   => 'root',
      group   => 'bin',
      source => "puppet:///modules/smartd/${smartd::service_file}",
    }->
    file { $smartd::manifest_file: 
      ensure  => "present",
      path    => "${smartd::manifest_dir}/${smartd::manifest_file}",
      mode    => '0444',
      owner   => 'root',
      group   => 'sys',
      source => "puppet:///modules/smartd/${smartd::manifest_file}",
    }~>
    exec { "${module_name}-import-svc":
      path        => ["/sbin","/usr/sbin"],
      command     => "svccfg import ${smartd::manifest_dir}/${smartd::manifest_file}",
      refreshonly => true,
    }
  }
  
  file { $smartd::config_dir:
    ensure  => 'directory',
  }
  
  file { $smartd::config_file:
    ensure  => 'present',
    path    => "${smartd::config_dir}/${smartd::config_file}",
    content => template("smartd/${smartd::config_file}.erb"),
    require => File [$smartd::config_dir],
  }
  
  if ($::operatingsystem == 'OmniOS'){
    file { $smartd::logadm_file:
      ensure => 'present',
      path   => "${smartd::logadm_dir}/smartd.conf",
      source => "puppet:///modules/smartd/${smartd::logadm_file}",
    }~>
    exec { "${module_name}-logadm-refresh":
      path        => ["/sbin","/usr/sbin"],
      command     => "logadm",
      refreshonly => true,
    }
    #notify {"we are here":}
  }
}
