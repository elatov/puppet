# == Class subsonic::config
#
# This class is called from subsonic
#
class subsonic::config inherits subsonic {
  ensure_resource ('user',$subsonic_settings['user'],{ 'ensure'=> 'present' })
    
  if $subsonic_service_file =~ /(?i:service)/ {
    file { 'subsonic_service_file':
      ensure  => "present",
      path    => "${subsonic_service_dir}/${subsonic_service_file}",
      mode    => '0644',
      content => template("subsonic/${subsonic_service_file}.erb"),
    }~>
    exec { "subsonic-reload-systemd":
      path    => ["/bin","/usr/bin"],
      command => "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $subsonic_service_file =~ /(?i:init)/ {
    file { 'subsonic_init_file':
      ensure  => 'present',
      path    => "${subsonic_service_dir}/subsonic",
      mode    => '0755',
      content => "puppet:///modules/subsonic/${subsonic_service_file}",
    }
  }
  
  
  file { 'subsonic_sysconf_dir':
    ensure  => 'directory',
    path    => $subsonic_config_dir,
  }
  
  file { 'subsonic_sysconf_file':
    ensure  => 'present',
    path    => "${subsonic_config_dir}/subsonic",
    content => template("subsonic/${subsonic_config_file}.erb"),
    require => File ['subsonic_sysconf_dir'],
  }
}
