# == Class my_wp::config
#
# This class is called from my_wp
#
class my_wp::config {

  ensure_resource ('user',$my_wp::settings['user'],{ 'ensure'=> 'present' })
    
  if $my_wp::service_file =~ /(?i:service)/ {
    file { $my_wp::service_file:
      ensure  => "present",
      path    => "${my_wp::service_dir}/${my_wp::service_file}",
      mode    => '0644',
      content => template("my_wp/${my_wp::service_file}.erb"),
    }~>
    exec { "${module_name}-reload-systemd":
      path    		=> ["/bin","/usr/bin"],
      command 		=> "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $my_wp::service_file =~ /(?i:init)/ {
    file { $my_wp::service_file:
      ensure  => 'present',
      path    => "${my_wp::service_dir}/my_wp",
      mode    => '0755',
      content => "puppet:///modules/my_wp/${my_wp::service_file}",
    }
  }
  
  
  file { $my_wp::config_dir:
    ensure  => 'directory',
  }
  
  file { $my_wp::config_file:
    ensure  => 'present',
    path    => "${my_wp::config_dir}/my_wp",
    content => template("my_wp/${my_wp::config_file}.erb"),
    require => File [$my_wp::config_dir],
  }
}
