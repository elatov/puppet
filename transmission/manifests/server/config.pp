# See README.md for further information on usage.
class transmission::server::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  
  ensure_resource ('user',$transmission::server::settings['user'],{ 'ensure'=> 'present' })
  
  file { $transmission::server::log_dir:
    ensure  => 'directory',
    path    => $transmission::server::log_dir,
    owner   => $transmission::server::settings['user'],
    group   => $transmission::server::settings['user'],
  }
  
    file { $transmission::server::log_file:
    ensure  => 'present',
    path    => "${transmission::server::log_dir}/${transmission::server::log_file}",
    owner   => $transmission::server::settings['user'],
    group   => $transmission::server::settings['user'],
    require => File[$transmission::server::log_dir],
  }
  
  if $transmission::server::service_file =~ /(?i:service)/ {
	  file { $transmission::server::service_file:
	    ensure  => 'present',
	    path    => "${transmission::server::service_dir}/${transmission::server::service_file}",
	    mode    => '0644',
	    content => template("transmission/${transmission::server::service_file}.erb"),
	  }~>
	  exec { "${module_name}-reload-systemd":
      path    => ["/bin","/usr/bin"],
      command => "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $transmission::server::service_file =~ /(?i:init)/ {
    file { $transmission::server::service_file:
      ensure  => 'present',
      path    => "${transmission::server::service_dir}/${transmission::server::service_file}",
      mode    => '0755',
      content => "puppet:///modules/transmission/${transmission::server::service_file}",
    }
  }

  if ($transmission::server::settings['initial_setup'] == true){  
	  file { $transmission::server::config_dir:
	    ensure  => 'directory',
	    path    => $transmission::server::config_dir,
	    owner   => $transmission::server::settings['user'],
	    group   => $transmission::server::settings['user'],
	  }
	  
		file { $transmission::server::config_file:
			ensure  => 'present',
			path    => "${transmission::server::config_dir}/${transmission::server::config_file}",
			owner   => $transmission::server::settings['user'],
			group   => $transmission::server::settings['user'],
			content => template("transmission/${transmission::server::config_file}.erb"),
			require => File [$transmission::server::config_dir],
			replace => false,
		}
	}
	
	define modify_config ( $key=$title,$config_file,$transmission_settings ) {
	
		$con = "/files${config_file}"
		
		$value = $transmission_settings[$key]
		notice $value
		
		augeas {"transmission_settings_file_${key}":
			incl    => "${config_file}", 
			lens    => 'Json.lns',
			context => $con,
			changes => "set dict/entry[.= \"$key\"]/string $value",
			onlyif  => "match dict/entry[.= \"$key\"]/string not_include $value",
			#onlyif  => "match dict/entry[.= \"watch-dir\"]/string size==0",
	 }
	}
}



