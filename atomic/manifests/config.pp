# == Class atomic::config
#
# This class is called from atomic
#
class atomic::config inherits atomic::params {

  file { $atomic_config_dir:
    ensure  => 'directory',
  }
  
	$keys = keys($atomic_settings)
#	$values = values($atomic_settings)
#	#notify {$keys:}
#	#notify {$atomic_settings:}
#	notify {$values:}
#	$num = inline_template ("<% @atomic_settings['includepkgs'].each_with_index do |val, ind|%> [<%= ind %>] <% end -%>")
#  $ar = any2array($num)
#  
#  notify {$ar:}
#	#notify {$atomic_settings['includepkgs'][1]:}
#	
#	atomic::settings {$ar:
#	  key  => 'includepkgs'
#	}
	
	atomic::settings { $keys:
		config_file => "${atomic_config_dir}/${atomic_config_file}",
		settings => $atomic_settings,
	}~>
	exec { "${module_name}-yum-refresh":
		path        => ["/bin","/usr/bin"],
		command     => "yum clean all",
		refreshonly => true,
	}
	
  
}
