# == Class my_wp::config
#
# This class is called from my_wp
#
class my_wp::config {

  if ($my_wp::enable_main_wp){
    $wp_name = 'wordpress'
	  
    file { "${my_wp::apache_confdir}/${wp_name}.conf":
	    ensure  => 'present',
	    content  => template("my_wp/apache.conf.erb"),
	  }
  }
  
  if ($my_wp::enable_cs_wp){
	  $wp_name = 'cs4113'
    
    file { "${my_wp::apache_confdir}/${wp_name}.conf":
      ensure  => 'present',
      content  => template("my_wp/apache.conf.erb"),
    }
	}
}
