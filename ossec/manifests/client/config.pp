# == Class ossec::client::config
#
# This class is called from ossec::client
#
class ossec::client::config {
  
  if ($ossec::client::settings['add_user'] != undef and $ossec::client::settings['initial_setup'] == false) {
    User <| title == "${ossec::client::settings['add_user']}" |> { groups +> ["ossec"] }
  }
  
  
  file { $ossec::client::config_dir:
    ensure  => 'directory',
  }
  
  if ($::osfamily == 'Debian'){
	  file { $ossec::client::config_file:
	    ensure  => 'present',
	    path    => "${ossec::client::config_dir}/${ossec::client::config_file}",
	    content => template('ossec/ossec-agent.conf.erb'),
	    require => File [$ossec::client::config_dir],
	  }
	}elsif ($::osfamily == 'RedHat'){
	  file { $ossec::client::config_file:
      ensure  => 'present',
      path    => "${ossec::client::config_dir}/${ossec::client::config_file}",
      content => template("ossec/${ossec::client::config_file}.erb"),
      require => File [$ossec::client::config_dir],
    }
	}
  
  if ($ossec::client::settings['timezone_file'] != undef) {
	  file {"${ossec::client::config_dir}/localtime":
	    ensure  => 'link',
	    target   => $ossec::client::settings['timezone_file'],
	    force   => true
	  }
  }
  
  if ($::operatingsystem !~ /(?i:OmniOS|Debian)/){
	  augeas {"${module_name}-ossec-hids-su-owner":
	    lens    => 'Logrotate.lns',
	    incl    => '/etc/logrotate.d/ossec-hids',
	    changes => ["setm rule[*] su/owner ossec","setm rule[*] su/group ossec"],
	    onlyif  => "match rule[*]/su not_include ossec",
	  }
  }
  
  if ($::operatingsystem == 'OmniOS'){
    file { $ossec::client::manifest_file: 
      ensure  => "present",
      path    => "${ossec::client::manifest_dir}/${ossec::client::manifest_file}",
      mode    => '0444',
      owner   => 'root',
      group   => 'sys',
      content => template("ossec/${ossec::client::manifest_file}.erb"),
    }~>
    exec { "${module_name}-import-svc":
      path        => ["/sbin","/usr/sbin"],
      command     => "svccfg import ${ossec::client::manifest_dir}/${ossec::client::manifest_file}",
      refreshonly => true,
    }
  }
}
