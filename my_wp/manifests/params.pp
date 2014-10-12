# == Class my_wp::params
#
# This class is meant to be called from my_wp
# It sets variables according to platform
#
class my_wp::params {
	
	$my_wp_enable_main_wp  = true
	$my_wp_main_wp_name    = 'wordpress'
	$my_wp_main_db_pass    = 'password'
	
	$my_wp_enable_cs_wp    = true
	$my_wp_cs_wp_name      = 'cs4113'
  $my_wp_cs_db_pass      = 'password'
	
	case $::osfamily {
		'Debian': {
			$my_wp_apache_docroot	  = '/var/www'
      $my_wp_wp_owner         = 'www-data'
      $my_wp_wp_group         = 'www-data'
      $my_wp_apache_conf_dir  = '/etc/apache2/conf.d'
		}
		'RedHat': {
			$my_wp_apache_docroot    = '/var/www'
      $my_wp_wp_owner         = 'www'
      $my_wp_wp_group         = 'www'
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
