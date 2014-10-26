# == Class plexms::config
#
# This class is called from plexms
#
class plexms::config inherits plexms::params {

  ensure_resource ('user',$plexms_settings['User'],{ 'ensure'=> 'present' })
    
  if $plexms_service_file =~ /(?i:service)/ {
		$keys = keys($plexms_settings)
		
		#include plexms::settings

		plexms::settings { $keys:
			config_file => "${plexms_service_dir}/${plexms_service_file}",
			settings => $plexms_settings,
		}~>
    exec { "plexms-reload-systemd":
      path    		=> ["/bin","/usr/bin"],
      command 		=> "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $plexms_service_file =~ /(?i:init)/ {
    file { $plexms_service_file:
      ensure  => 'present',
      path    => "${plexms_service_dir}/plexms",
      mode    => '0755',
      content => "puppet:///modules/plexms/${plexms_service_file}",
    }
  }
  
  
#  file { $plexms_config_dir:
#    ensure  => 'directory',
#  }
#  
#  file { $plexms_config_file:
#    ensure  => 'present',
#    path    => "${plexms_config_dir}/plexms",
#    content => template("plexms/${plexms_config_file}.erb"),
#    require => File [$plexms_config_dir],
#  }
}
