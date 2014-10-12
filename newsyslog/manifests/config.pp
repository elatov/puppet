# == Class newsyslog::config
#
# This class is called from newsyslog
#
class newsyslog::config {

  ensure_resource ('user',$newsyslog::settings['user'],{ 'ensure'=> 'present' })
    
  if $newsyslog::service_file =~ /(?i:service)/ {
    file { $newsyslog::service_file:
      ensure  => "present",
      path    => "${newsyslog::service_dir}/${newsyslog::service_file}",
      mode    => '0644',
      content => template("newsyslog/${newsyslog::service_file}.erb"),
    }~>
    exec { "${module_name}-reload-systemd":
      path    		=> ["/bin","/usr/bin"],
      command 		=> "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $newsyslog::service_file =~ /(?i:init)/ {
    file { $newsyslog::service_file:
      ensure  => 'present',
      path    => "${newsyslog::service_dir}/newsyslog",
      mode    => '0755',
      content => "puppet:///modules/newsyslog/${newsyslog::service_file}",
    }
  }
  
  
  file { $newsyslog::config_dir:
    ensure  => 'directory',
  }
  
  file { $newsyslog::config_file:
    ensure  => 'present',
    path    => "${newsyslog::config_dir}/newsyslog",
    content => template("newsyslog/${newsyslog::config_file}.erb"),
    require => File [$newsyslog::config_dir],
  }
}
