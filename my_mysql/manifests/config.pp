# == Class my_mysql::config
#
# This class is called from my_mysql
#
class my_mysql::config {

  ensure_resource ('user',$my_mysql::settings['user'],{ 'ensure'=> 'present' })
    
  if $my_mysql::service_file =~ /(?i:service)/ {
    file { $my_mysql::service_file:
      ensure  => "present",
      path    => "${my_mysql::service_dir}/${my_mysql::service_file}",
      mode    => '0644',
      content => template("my_mysql/${my_mysql::service_file}.erb"),
    }~>
    exec { "${module_name}-reload-systemd":
      path    		=> ["/bin","/usr/bin"],
      command 		=> "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $my_mysql::service_file =~ /(?i:init)/ {
    file { $my_mysql::service_file:
      ensure  => 'present',
      path    => "${my_mysql::service_dir}/my_mysql",
      mode    => '0755',
      content => "puppet:///modules/my_mysql/${my_mysql::service_file}",
    }
  }
  
  
  file { $my_mysql::config_dir:
    ensure  => 'directory',
  }
  
  file { $my_mysql::config_file:
    ensure  => 'present',
    path    => "${my_mysql::config_dir}/my_mysql",
    content => template("my_mysql/${my_mysql::config_file}.erb"),
    require => File [$my_mysql::config_dir],
  }
}
