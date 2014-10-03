# == Class my_apache::install
#
class my_apache::install {

  class { 'apache': 
    mpm_module          => 'prefork',
    #default_confd_files => false,
    default_vhost       => false,
  }
  
  apache::vhost {"${my_apache::settings['hostname']}":
    #vhost_name         => $my_apache::settings['hostname'],
    servername         => $my_apache::settings['hostname'],
    serveraliases       => ['kerch.moxz.tk',],
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
