class couchpotato::config {
  file { $couchpotato::install_dir:
    ensure  => directory,
    owner   => $couchpotato::user,
    recurse => true,
    force   => true,
    require => Class['couchpotato::install'],
  }
  
  if $couchpotato::service_file =~ /(?i:init)/ {
    file { '/etc/init.d/couchpotato':
      ensure   => "file",
      source   => "puppet:///modules/couchpotato/$couchpotato::service_file",
      mode     => '0755',
      require  => Vcsrepo[$couchpotato::install_dir],
    }
    
    file { '/etc/sysconfig/couchpotato':
      ensure   => "file",
      content  => template ("couchpotato/${couchpotato::sys_config_file}.erb"),
      mode     => '0644',
      require  => Vcsrepo[$couchpotato::install_dir],
    }
  }
  
  if $couchpotato::service_file =~ /(?i:service)/ {
    file { "/usr/lib/systemd/system/$couchpotato::service_file":
      ensure   => "file",
      content  => template ("couchpotato/${couchpotato::service_file}.erb"),
      mode     => '0644',
      require  => Vcsrepo[$couchpotato::install_dir],
      notify    => Exec ["cp-reload-systemd"]
    }
    
    exec { "cp-reload-systemd":
      path    => ["/bin","/usr/bin"],
      command => "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  file {"/home/$couchpotato::user/.couchpotato":
    ensure => directory,
    owner => $couchpotato::user,
  }
  
  file {"/home/$couchpotato::user/.couchpotato/$couchpotato::settings_file":
    ensure => "present",
    source => "puppet:///modules/couchpotato/$couchpotato::settings_file",
    
    
  }
}