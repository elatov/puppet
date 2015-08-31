# == Class my_apache::install
#
class my_apache::install {

#  if ($my_apache::settings['default_mods'] != undef) {
#    notice("Running with first drop $my_apache::settings['default_mods'] test")
#    class { 'apache': 
#      mpm_module          => 'prefork',
#      default_confd_files => false,
#      default_vhost       => false,
#      purge_configs       => false,
#      confd_dir           => $my_apache::config_dir,
#      default_mods        => "${my_apache::settings['default_mods']}"
#    }
#  }else{
    notice("Running with second drop $my_apache::settings['default_mods'] test")
		class { 'apache': 
			mpm_module          => 'prefork',
			default_confd_files => false,
			default_vhost       => false,
			purge_configs       => false,
			confd_dir           => $my_apache::config_dir,
			default_mods        => false;
		}
#  }
  
  apache::vhost {"${my_apache::settings['hostname']}":
    #vhost_name         => $my_apache::settings['hostname'],
    servername         => $my_apache::settings['hostname'],
    serveraliases       => ["${my_apache::settings['serveralias']}",],
    ip                  => $::ipaddress,
    port                => '80',
    docroot             => '/var/www',
    rewrites            => [ {rewrite_rule => ['^(/)?$ /wordpress/ [R=301,L]']}],
    
  }
  
  class {'::apache::mod::php':
    package_name => $my_apache::settings['php_pkg'],
  }
  
   class {'::apache::mod::proxy': }
   class {'::apache::mod::proxy_http': }

}
