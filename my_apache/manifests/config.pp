# == Class my_apache::config
#
# This class is called from my_apache
#
class my_apache::config {

  file { '/etc/apache2/pass':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'www-data',
    mode    => '0750',
    require => Group['www-data']  
  }
  
#  file { $my_apache::settings['conf_proxy_sn'] :
#    ensure  => 'present',
#    path    => "${my_apache::config_dir}/${my_apache::settings['conf_proxy_sn']}",
#    source  => "puppet:///modules/my_apache/${my_apache::settings['conf_proxy_sn']}",
#    notify  => Service['httpd'],
#  }
  
  file { $my_apache::settings['conf_proxy'] :
    ensure  => 'present',
    path    => "${my_apache::config_dir}/${my_apache::settings['conf_proxy']}",
    source  => "puppet:///modules/my_apache/${my_apache::settings['conf_proxy']}",
    notify  => Service['httpd'],
  }->
  httpauth { $my_apache::settings['htuser']:
	  file     => '/etc/apache2/pass/htpasswd',
	  password => $my_apache::settings['htpasswd'],
	  realm => 'splunk',
	  mechanism => 'basic',
	  ensure => present,
	  require  => File['/etc/apache2/pass'],
  }->
  file {'/etc/apache2/pass/htpasswd':
    ensure  => 'present',
    mode    => '0640',
    group   => 'www-data',
    require => Group['www-data']
  }
}
