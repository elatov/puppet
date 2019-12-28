# == Class atomic::config
#
# This class is called from atomic
#
class atomic::config {

  file { $atomic::config_dir:
    ensure  => 'directory',
  }
  
  # Grab all the yum-conf settings
	$keys = keys($atomic::settings['yum_conf'])
	
	atomic::settings { $keys:
		config_file   => "${atomic::config_dir}/${atomic::config_file}",
		settings_hash => $atomic::settings['yum_conf'],
	}~>
	exec { "${module_name}-yum-refresh":
		path        => ["/bin","/usr/bin"],
		command     => "dnf clean all",
		refreshonly => true,
	}
}
