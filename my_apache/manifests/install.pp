# == Class my_apache::install
#
class my_apache::install {

  if ($my_apache::settings['default_mods'] != undef) {
    class { 'apache': 
      mpm_module          => 'prefork',
      default_confd_files => false,
      default_vhost       => false,
      purge_configs       => false,
      confd_dir           => $my_apache::config_dir,
      default_mods        => $my_apache::settings['default_mods'],
      servername          => $my_apache::settings['hostname'],
    }
  }else{
		class { 'apache': 
			mpm_module          => 'prefork',
			default_confd_files => false,
			default_vhost       => false,
			purge_configs       => false,
			confd_dir           => $my_apache::config_dir,
			default_mods        => true,
		}
  }
  
  apache::vhost {"kerch":
    #vhost_name         => $my_apache::settings['hostname'],
#    servername         => 'kerch.kar.int',
    serveraliases       => ["${my_apache::settings['serveralias']}",],
    ip                  => $::ipaddress,
    port                => '80',
    docroot             => '/var/www',
    rewrites            => [ {rewrite_rule => ['^(/)?$ /wordpress/ [R=301,L]']}],
    
  }
  
  class {'::apache::mod::php':
    package_name => $my_apache::settings['php_pkg'],
#    path         => '/usr/lib/apache2/modules/libphp5.so',
  }
  
   class {'::apache::mod::proxy': }
   class {'::apache::mod::proxy_http': }

}
