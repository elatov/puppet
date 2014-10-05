# == Class ossec::server::config
#
# This class is called from ossec::server
#
class ossec::server::config inherits ossec::params {

  ensure_resource ('user',$ossec_server_settings['user'],{ 'ensure'=> 'present' })
    
  if $ossec_server_service_file =~ /(?i:service)/ {
    file { $ossec_server_service_file:
      ensure  => "present",
      path    => "${ossec_server_service_dir}/${ossec_server_service_file}",
      mode    => '0644',
      content => template("ossec/${ossec_server_service_file}.erb"),
    }~>
    exec { "${module_name}-reload-systemd":
      path    		=> ["/bin","/usr/bin"],
      command 		=> "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $ossec_server_service_file =~ /(?i:init)/ {
    file { $ossec_server_service_file:
      ensure  => 'present',
      path    => "${ossec_server_service_dir}/ossec",
      mode    => '0755',
      content => "puppet:///modules/ossec/${ossec_server_service_file}",
    }
  }
  
  
  file { $ossec_server_config_dir:
    ensure  => 'directory',
  }
  
  file { $ossec_server_config_file:
    ensure  => 'present',
    path    => "${ossec_server_config_dir}/ossec",
    content => template("ossec/${ossec_server_config_file}.erb"),
    require => File [$ossec_server_config_dir],
  }
}
