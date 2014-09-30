# == Class my_mysql::client::config
#
# This class is called from my_mysql::client
#
class my_mysql::client::config {

  ensure_resource ('user',$my_mysql::client_settings['user'],{ 'ensure'=> 'present' })
    
  if $my_mysql::client_service_file =~ /(?i:service)/ {
    file { $my_mysql::client_service_file:
      ensure  => "present",
      path    => "${my_mysql_client_service_dir}/${my_mysql::client_service_file}",
      mode    => '0644',
      content => template("my_mysql/${my_mysql::client_service_file}.erb"),
    }~>
    exec { "${module_name}-client-reload-systemd":
      path    		=> ["/bin","/usr/bin"],
      command 		=> "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $my_mysql::client_service_file =~ /(?i:init)/ {
    file { $my_mysql::client_service_file:
      ensure  => 'present',
      path    => "${my_mysql::client_service_dir}/my_mysql",
      mode    => '0755',
      content => "puppet:///modules/my_mysql/${my_mysql::client_service_file}",
    }
  }
  
  
  file { $my_mysql::client_config_dir:
    ensure  => 'directory',
  }
  
  file { $my_mysql::client_config_file:
    ensure  => 'present',
    path    => "${my_mysql::client_config_dir}/my_mysql",
    content => template("my_mysql/${my_mysql::client_config_file}.erb"),
    require => File [$my_mysql::client_config_dir],
  }
}
