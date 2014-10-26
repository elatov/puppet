# == Class nfs::client::config
#
# This class is called from nfs::client
#
class nfs::client::config {

#  ensure_resource ('user',$nfs::client::settings['user'],{ 'ensure'=> 'present' })
#    
#  if $nfs_client_service_file =~ /(?i:service)/ {
#    file { $nfs_client_service_file:
#      ensure  => "present",
#      path    => "${nfs_client_service_dir}/${nfs_client_service_file}",
#      mode    => '0644',
#      content => template("nfs/${nfs_client_service_file}.erb"),
#    }~>
#    exec { "${module_name}-reload-systemd":
#      path    		=> ["/bin","/usr/bin"],
#      command 		=> "systemctl daemon-reload",
#      refreshonly => true,
#    }
#  }
#  
#  if $nfs_client_service_file =~ /(?i:init)/ {
#    file { $nfs_client_service_file:
#      ensure  => 'present',
#      path    => "${nfs_client_service_dir}/nfs",
#      mode    => '0755',
#      content => "puppet:///modules/nfs/${nfs_client_service_file}",
#    }
#  }
#  
#  
#  file { $nfs_client_config_dir:
#    ensure  => 'directory',
#  }
#  
#  file { $nfs_client_config_file:
#    ensure  => 'present',
#    path    => "${nfs_client_config_dir}/nfs",
#    content => template("nfs/${nfs_client_config_file}.erb"),
#    require => File [$nfs_client_config_dir],
#  }
}
