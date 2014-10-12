# == Class ossec::server::config
#
# This class is called from ossec::server
#
class ossec::server::config {

  if ($ossec::server::settings['add_user'] != undef) {
    User <| title == "${ossec::server::settings['add_user']}" |> { groups +> ["ossec"] }
  }
      
  file { $ossec::server::config_dir:
    ensure  => 'directory',
  }
  
  file { $ossec::server::config_file:
    ensure  => 'present',
    path    => "${ossec::server::config_dir}/${ossec::server::config_file}",
    content => template("ossec/ossec-server.conf.${::operatingsystem}.erb"),
    require => File [$ossec::server::config_dir],
  }
  
  file { "${ossec::server::config_dir}/etc/shared":
    mode => '775',
  }
}
