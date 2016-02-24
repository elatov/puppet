# == Class ossec::server::config
#
# This class is called from ossec::server
#
class ossec::server::config {

  if ($ossec::server::settings['add_user'] != undef) {
    User <| title == "${ossec::server::settings['add_user']}" |> { groups +> ["ossec"] }
  }
  
  if ("${ossec::server::settings['config']['syslog_enabled']}"){
    file { "${ossec::server::home_dir}/bin/.process_list":
      ensure => 'present',
      content => "CSYSLOG_DAEMON=ossec-csyslogd\n",
    }
  }    
  file { $ossec::server::config_dir:
    ensure  => 'directory',
  }
  
  file { $ossec::server::config_file:
    ensure  => 'present',
    path    => "${ossec::server::config_dir}/${ossec::server::config_file}",
    content => template("ossec/ossec-server.conf.${::operatingsystem}.erb"),
    require => File[$ossec::server::config_dir],
  }
  
  file { "${ossec::server::config_dir}/shared":
    ensure => 'directory',
    mode   => '775',
    group  => 'ossec',
  }
  
  file { "${ossec::server::home_dir}/queue":
    ensure => 'directory',
    mode   => '755',
    owner  => 'ossec',
  }
  
	file { "${ossec::server::home_dir}/queue/rootcheck":
		ensure => 'directory',
		mode   => '575',
		group  => 'ossec',
	}
  
}
