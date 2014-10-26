# See README.md for further information on usage.
class transmission::client::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  
  ensure_resource ('user',$transmission::client::settings['user'],{ 'ensure'=> 'present' })
  ensure_resource ('file',$transmission::client::config_dir,{ 'ensure'=> 'present' })
  
  if ($transmission::client::settings['initial_setup'] == true){
	  file { $transmission::client::config_file:
	    ensure  => 'present',
	    path    => "${transmission::client::config_dir}/.${transmission::client::config_file}",
	    owner   => $transmission::client::settings['user'],
	    group   => $transmission::client::settings['user'],
	    mode    => '0600',
	    content => template("transmission/${transmission::client::config_file}.erb"),
	    require => File ['transmission_client_config_dir'],
	  }->
	  notify{"Go fill out the .netrc file":}
  } 
}
