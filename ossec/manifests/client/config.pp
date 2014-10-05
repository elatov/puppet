# == Class ossec::client::config
#
# This class is called from ossec::client
#
class ossec::client::config inherits ossec::params {
  
  User <| title == "${ossec_client_settings['add_user']}" |> { groups +> ["ossec"] }
  
#  User <| title == "elatov" |> { groups +> ["ossec"] }

#  if $ossec_client_service_file =~ /(?i:service)/ {
#    file { $ossec_client_service_file:
#      ensure  => "present",
#      path    => "${ossec_client_service_dir}/${ossec_client_service_file}",
#      mode    => '0644',
#      content => template("ossec/${ossec_client_service_file}.erb"),
#    }~>
#    exec { "${module_name}-reload-systemd":
#      path    		=> ["/bin","/usr/bin"],
#      command 		=> "systemctl daemon-reload",
#      refreshonly => true,
#    }
#  }
  
#  if $ossec_client_service_file =~ /(?i:init)/ {
#    file { $ossec_client_service_file:
#      ensure  => 'present',
#      path    => "${ossec_client_service_dir}/ossec",
#      mode    => '0755',
#      content => "puppet:///modules/ossec/${ossec_client_service_file}",
#    }
#  }
  
  
  file { $ossec_client_config_dir:
    ensure  => 'directory',
  }
  
  file { $ossec_client_config_file:
    ensure  => 'present',
    path    => "${ossec_client_config_dir}/ossec-agent.conf",
    content => template("ossec/${ossec_client_config_file}.erb"),
    require => File [$ossec_client_config_dir],
  }
  
  file {"${ossec_client_config_dir}/localtime":
    ensure  => 'link',
    target   => $ossec_client_settings['timezone_file'],
    force   => true
  }
  
  augeas {"/etc/logrotate.d/ossec-hids-su-owner":
    lens    => 'Logrotate.lns',
    incl    => '/etc/logrotate.d/ossec-hids',
    changes => ["setm rule[*] su/owner ossec","setm rule[*] su/group ossec"],
    onlyif  => "match rule[*]/su not_include ossec",
  }

}
