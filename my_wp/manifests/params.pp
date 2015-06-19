# == Class my_wp::params
#
# This class is meant to be called from my_wp
# It sets variables according to platform
#
class my_wp::params {
  
  $default_settings = { 'enable_main_wp'  => true,
                        'main_wp_name'    => 'wordpress',
                        'main_db_pass'    => 'password',  
                        'enable_cs_wp'    => true,
                        'cs_wp_name'      => 'cs4113',
                        'cs_db_pass'      => 'password', 
                      }
		
	case $::osfamily {
		'Debian': {
			$apache_docroot	  = '/var/www'
      $wp_owner         = 'www-data'
      $wp_group         = 'www-data'
      $apache_conf_dir  = '/etc/apache2/conf-enable'
		}
		'RedHat': {
			$apache_docroot    = '/var/www'
      $wp_owner         = 'www'
      $wp_group         = 'www'
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
