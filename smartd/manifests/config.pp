# == Class smartd::config
#
# This class is called from smartd
#
class smartd::config {

  ensure_resource ('user',$smartd::settings['user'],{ 'ensure'=> 'present' })
    
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
  
  if $smartd::service_file =~ /(?i:init)/ {
    file { $smartd::service_file:
      ensure  => 'present',
      path    => "${smartd::service_dir}/smartd",
      mode    => '0755',
      content => "puppet:///modules/smartd/${smartd::service_file}",
    }
  }
  
  
  file { $smartd::config_dir:
    ensure  => 'directory',
  }
  
  file { $smartd::config_file:
    ensure  => 'present',
    path    => "${smartd::config_dir}/smartd",
    content => template("smartd/${smartd::config_file}.erb"),
    require => File [$smartd::config_dir],
  }
}
