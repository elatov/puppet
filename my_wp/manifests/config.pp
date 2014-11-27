# == Class my_wp::config
#
# This class is called from my_wp
#
class my_wp::config {

  if ($my_wp::settings['enable_main_wp']){
	  
    file { "${my_wp::apache_confdir}/${my_wp::settings['main_wp_name']}.conf":
	    ensure  => 'present',
	    content  => template("my_wp/apache.conf.erb"),
	  }
  }
  
  if ($my_wp::settings['enable_cs_wp']){
    
    file { "${my_wp::apache_confdir}/${my_wp::settings['cs_wp_name']}.conf":
      ensure  => 'present',
      content  => template("my_wp/apache.conf.erb"),
    }
	}
}
