# == Class plexms::config
#
# This class is called from plexms
#
class plexms::config {

  if $plexms::service_file =~ /(?i:service)/ {
		$keys = keys($plexms::settings['conf'])
		
		plexms::settings { $keys:
			config_file  => "${plexms::service_dir}/${plexms::service_file}",
			settings     => $plexms::settings['conf'],
		}~>
    exec { "${module_name}-reload-systemd":
      path    		=> ["/bin","/usr/bin"],
      command 		=> "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $plexms::service_file =~ /(?i:init)/ {
    file { $plexms::service_file:
      ensure  => 'present',
      path    => "${plexms::service_dir}/plexms",
      mode    => '0755',
      source  => "puppet:///modules/plexms/${plexms::service_file}",
    }
  }
}
