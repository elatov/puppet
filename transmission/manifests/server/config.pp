# See README.md for further information on usage.
class transmission::server::config inherits transmission::server {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  
  ensure_resource ('user',$username,{ 'ensure'=> 'present' })
  
  file { 'transmission_daemon_logdir':
    ensure  => $log_dir_ensure,
    path    => $log_dir,
    owner   => $server_username,
    group   => $server_username,
  }
  
    file { 'transmission_daemon_log_file':
    ensure  => $log_file_ensure,
    path    => "${log_dir}/${log_file}",
    owner   => $server_username,
    group   => $server_username,
    require => File['transmission_daemon_logdir'],
  }
  
  if $service_file =~ /(?i:service)/ {
	  file { 'transmission_daemon_service_file':
	    ensure  => $service_file_ensure,
	    path    => "${service_file_dir}/${service_file}",
	    mode    => '0644',
	    content => template("transmission/${$service_file}.erb"),
	  }~>
	  exec { "transmission-reload-systemd":
      path    => ["/bin","/usr/bin"],
      command => "systemctl daemon-reload",
      refreshonly => true,
    }
  }
  
  if $service_file =~ /(?i:init)/ {
    file { 'transmission_daemon_init_file':
      ensure  => $service_file_ensure,
      path    => "${service_file_dir}/${service_file}",
      mode    => '0755',
      content => "puppet:///modules/transmission/${service_file}",
    }
  }
  
  
  file { 'transmission_daemon_config_dir':
    ensure  => $config_dir_ensure,
    path    => $config_dir,
    owner   => $server_username,
    group   => $server_username,
  }
  
	file { 'transmission_daemon_config_file':
		ensure  => $config_file_ensure,
		path    => "${config_dir}/${config_file}",
		owner   => $server_username,
		group   => $server_username,
		content => template("transmission/${config_file}.erb"),
		require => File ['transmission_daemon_config_dir'],
		replace => false,
	}
	
	
	
	## Get the values from a hash and store in dirs
	$dirs = values($transmission_settings)
	
	# Make sure dirs is a valid array and remove any duplicate entries
	validate_array($dirs)
	$udirs = unique($dirs)
			
	file { $udirs:
		ensure => "directory",
		owner => $username,
		group => $username,
	}	
  
  #$changes_string = inline_template("<% @transmission_settings.each_pair do |key, val| -%>set <%= key %> <%= val %>,<% end -%>")
  #$changes_array = split($changes_string, ",")
  
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
  
  $keys = keys($transmission_settings)
	
	modify_config { $keys:
		config_file => "${config_dir}/${config_file}",
		transmission_settings => $transmission_settings,
		require => File ['transmission_daemon_config_dir'],
	}
}



