class couchpotato::config {
  ensure_resource ('file',$couchpotato::install_dir, { ensure  => directory})
  
  if $couchpotato::service_file =~ /(?i:init)/ {
    file { $couchpotato::service_file:
      ensure   => 'file',
      source   => "puppet:///modules/couchpotato/$couchpotato::service_file",
      path     => "${$couchpotato::service_dir}/couchpotato",
      mode     => '0755',
    }
    
    file { $couchpotato::config_file :
      ensure   => 'file',
      path     => "${$couchpotato::config_dir}/couchpotato",
      content  => template ("couchpotato/${couchpotato::config_file}.erb"),
      mode     => '0644',
    }
  }
  
  if $couchpotato::service_file =~ /(?i:service)/ {
    file { $couchpotato::service_file:
      ensure   => 'file',
      path     => "${couchpotato::service_dir}/${couchpotato::service_file}",
      content  => template ("couchpotato/${couchpotato::service_file}.erb"),
      mode     => '0644',
      notify    => Exec ["${module_name}-reload-systemd"]
    }
    
    exec { "${module_name}-reload-systemd":
      path        => ["/bin","/usr/bin"],
      command     => "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  file {"${couchpotato::user_home_dir}/.couchpotato":
    ensure => 'directory',
    owner => $couchpotato::settings['user'],
  }
  
  file {"${couchpotato::user_home_dir}/.couchpotato/$couchpotato::settings_file":
    ensure  => 'present',
    source  => "puppet:///modules/couchpotato/$couchpotato::settings_file",
    require => File["${couchpotato::user_home_dir}/.couchpotato"]
  }
}