# == Class exim::server::config
#
# This class is called from exim::server
#
class exim::server::config {

  
  if ($exim::server::settings['add_user'] != undef) {
    User <| title == "${exim::server::settings['add_user']}" |> { groups +> ['adm'] }
  }
    
  file { $exim::server::config_dir:
    ensure  => 'directory',
  }
  
  $keys = keys($exim::server::settings['config'])
  
  exim::server::settings { $keys:
    config_file     => "${exim::server::config_dir}/${exim::server::config_file}",
    settings_hash   => $exim::server::settings['config'],
  }~>
  exec {exim-server-update-config:
    path        => ['/sbin','/usr/sbin','/usr/bin','/bin'],
    command     => 'update-exim4.conf',
    refreshonly => true,
  }
  
  if ($exim::server::settings['aliases']){
    exim::aliases{$exim::server::settings['aliases']:
      alias_recipient => $exim::server::settings['alias_recipient'],
    }
  }
  
  file_line {'dis_ipv6':
		ensure  => 'present',
		line    => "disable_ipv6 = true ",
		path    => "${exim::server::template_conf_dir}/${exim::server::template_conf_file}",
		#match   => "^tls_verify_certificates*\ $",
  }
  
  if ($exim::server::initial_setup){
		file_line {'passwd.client':
			ensure  => 'present',
			line    => '*:USER@gmail.com:PASSWD',
			path    => "${exim::server::config_dir}/${exim::server::passwd_file}",
		}
    
    notify {"go set up the /etc/exim4/passwd.client file":}
  }
#  file { $exim::server::server_config_file:
#    ensure  => 'present',
#    path    => "${exim::server::server_config_dir}/exim",
#    content => template("exim/${exim::server::server_config_file}.erb"),
#    require => File [$exim::server::server_config_dir],
#  }
}
