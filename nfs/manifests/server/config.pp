# == Class nfs::server::config
#
# This class is called from nfs::server
#
class nfs::server::config inherits nfs::params {

#  ensure_resource ('user',$nfs_server_settings['user'],{ 'ensure'=> 'present' })
#    
#  if $nfs_server_service_file =~ /(?i:service)/ {
#    file { $nfs_server_service_file:
#      ensure  => "present",
#      path    => "${nfs_server_service_dir}/${nfs_server_service_file}",
#      mode    => '0644',
#      content => template("nfs/${nfs_server_service_file}.erb"),
#    }~>
#    exec { "${module_name}-reload-systemd":
#      path    		=> ["/bin","/usr/bin"],
#      command 		=> "systemctl daemon-reload",
#      refreshonly => true,
#    }
#  }
  
#  if $nfs_server_service_file =~ /(?i:init)/ {
#    file { $nfs_server_service_file:
#      ensure  => 'present',
#      path    => "${nfs_server_service_dir}/nfs",
#      mode    => '0755',
#      content => "puppet:///modules/nfs/${nfs_server_service_file}",
#    }
#  }
#  
#  
#  file { $nfs_server_config_dir:
#    ensure  => 'directory',
#  }
  
  file { $nfs_server_exports_file:
    ensure  => 'present',
    path    => $nfs_server_exports_file,
    content => template("nfs/exports.erb"),
  }~>
  exec {"${::modulename}-refresh-exportfs":
    path  => ['/sbin','/usr/sbin'],
    provider => 'shell',
    refreshonly => true,
    command     => 'exportfs -ra',
  }

}
