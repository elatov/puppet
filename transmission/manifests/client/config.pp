# See README.md for further information on usage.
class transmission::client::config inherits transmission::client {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  
  ensure_resource ('user',$username,{ 'ensure'=> 'present' })
  
    
  file { 'transmission_client_config_dir':
    ensure  => $config_dir_ensure,
    path    => $config_dir,
    owner   => $client_username,
    group   => $client_username,
  }
  
  file { 'transmission_client_config_file':
    ensure  => $config_file_ensure,
    path    => "${config_dir}/.${config_file}",
    owner   => $client_username,
    group   => $client_username,
    mode    => '0600',
    content => template("transmission/${config_file}.erb"),
    require => File ['transmission_client_config_dir'],
  }
    
}
