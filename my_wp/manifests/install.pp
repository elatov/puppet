# == Class my_wp::install
#
class my_wp::install {

  if ($my_wp::settings['enable_main_wp']){
		wordpress::instance { "$my_wp::settings['main_wp_name']":
		  install_dir     => "${my_wp::apache_docroot}/${my_wp::settings['main_wp_name']}",
		  create_db       => true,
		  create_db_user  => true,
		  db_name         => $my_wp::settings['main_wp_name'],
		  db_user         => $my_wp::settings['main_wp_name'],
      db_host         => 'localhost',
      db_password     => $my_wp::settings['main_wp_db_pass'],
      wp_owner        => $my_wp::wp_owner,
      wp_group        => $my_wp::wp_group,
		}
	}
	
	if ($my_wp::settings['enable_cs_wp']){
    wordpress::instance { "$my_wp::settings['cs_wp_name']":
      install_dir     => "${my_wp::apache_docroot}/${my_wp::settings['cs_wp_name']}",
      create_db       => true,
      create_db_user  => true,
      db_name         => $my_wp::settings['cs_wp_db_name'],
      db_user         => $my_wp::settings['cs_wp_db_user_name'],
      db_host         => 'localhost',
      db_password     => $my_wp::settings['cs_wp_db_pass'],
      wp_owner        => $my_wp::wp_owner,
      wp_group        => $my_wp::wp_group,
    }
  }
}
