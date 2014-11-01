# == Class extra_conf::config
#
# This class is called from extra_conf
#
class extra_conf::config {

#  ensure_resource ('user',$extra_conf::settings['user'],{ 'ensure'=> 'present' })
#    
#  if $extra_conf::service_file =~ /(?i:service)/ {
#    file { $extra_conf::service_file:
#      ensure  => "present",
#      path    => "${extra_conf::service_dir}/${extra_conf::service_file}",
#      mode    => '0644',
#      content => template("extra_conf/${extra_conf::service_file}.erb"),
#    }~>
#    exec { "${module_name}-reload-systemd":
#      path    		=> ["/bin","/usr/bin"],
#      command 		=> "systemctl daemon-reload",
#      refreshonly => true,
#    }
#  }
#  
#  if $extra_conf::service_file =~ /(?i:init)/ {
#    file { $extra_conf::service_file:
#      ensure  => 'present',
#      path    => "${extra_conf::service_dir}/extra_conf",
#      mode    => '0755',
#      content => "puppet:///modules/extra_conf/${extra_conf::service_file}",
#    }
#  }
#  
#  
#  file { $extra_conf::config_dir:
#    ensure  => 'directory',
#  }
#  
#  file { $extra_conf_config_file:
#    ensure  => 'present',
#    path    => "${extra_conf::config_dir}/extra_conf",
#    content => template("extra_conf/${extra_conf::config_file}.erb"),
#    require => File [$extra_conf::config_dir],
#  }
}
