# == Class pf::config
#
# This class is called from pf
#
class pf::config {

  ensure_resource ('user',$pf::settings['user'],{ 'ensure'=> 'present' })
    
  if $pf::service_file =~ /(?i:service)/ {
    file { $pf::service_file:
      ensure  => "present",
      path    => "${pf::service_dir}/${pf::service_file}",
      mode    => '0644',
      content => template("pf/${pf::service_file}.erb"),
    }~>
    exec { "${module_name}-reload-systemd":
      path    		=> ["/bin","/usr/bin"],
      command 		=> "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $pf::service_file =~ /(?i:init)/ {
    file { $pf::service_file:
      ensure  => 'present',
      path    => "${pf::service_dir}/pf",
      mode    => '0755',
      content => "puppet:///modules/pf/${pf::service_file}",
    }
  }
  
  
  file { $pf::config_dir:
    ensure  => 'directory',
  }
  
  file { $pf::config_file:
    ensure  => 'present',
    path    => "${pf::config_dir}/pf",
    content => template("pf/${pf::config_file}.erb"),
    require => File [$pf::config_dir],
  }
}
