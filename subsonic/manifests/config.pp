# == Class subsonic::config
#
# This class is called from subsonic
#
class subsonic::config {
  ensure_resource ('user',$subsonic::settings['conf']['user'],{ 'ensure'=> 'present' })
    
  if $subsonic::service_file =~ /(?i:service)/ {
    file { 'subsonic_service_file':
      ensure  => "present",
      path    => "${subsonic::service_dir}/${subsonic::service_file}",
      mode    => '0644',
      content => template("subsonic/${subsonic::service_file}.erb"),
    }~>
    exec { "subsonic-reload-systemd":
      path    => ["/bin","/usr/bin"],
      command => "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  ensure_resource ('file',$subsonic::config_dir,{ensure  => 'directory',})
  
  file { 'subsonic_sysconf_file':
    ensure  => 'present',
    path    => "${subsonic::config_dir}/subsonic",
    content => template("subsonic/${subsonic::config_file}.erb"),
    require => File ['subsonic_sysconf_dir'],
  }
}
