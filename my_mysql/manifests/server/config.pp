# == Class my_mysql::server::config
#
# This class is called from my_mysql::server
#
class my_mysql::server::config {

  ensure_resource ('user',$my_mysql::server::settings['user'],{ 'ensure'=> 'present' })
    
  if $my_mysql::server::service_file =~ /(?i:service)/ {
    file { $my_mysql::server::service_file:
      ensure  => "present",
      path    => "${my_mysql::server::service_dir}/${my_mysql::server::service_file}",
      mode    => '0644',
      content => template("my_mysql/${my_mysql::server::service_file}.erb"),
    }~>
    exec { "${module_name}-server-reload-systemd":
      path    		=> ["/bin","/usr/bin"],
      command 		=> "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $my_mysql::server::service_file =~ /(?i:init)/ {
    file { $my_mysql::server::service_file:
      ensure  => 'present',
      path    => "${my_mysql::server::service_dir}/my_mysql",
      mode    => '0755',
      content => "puppet:///modules/my_mysql/${my_mysql::server::service_file}",
    }
  }
  
  
  file { $my_mysql::server::config_dir:
    ensure  => 'directory',
  }
  
  file { $my_mysql::server::config_file:
    ensure  => 'present',
    path    => "${my_mysql::server::config_dir}/my_mysql",
    content => template("my_mysql/${my_mysql::server::config_file}.erb"),
    require => File [$my_mysql::server::config_dir],
  }
}
