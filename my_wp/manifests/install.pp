# == Class my_wp::install
#
class my_wp::install {

#  ensure_packages ($my_wp::package_name,{ 'ensure'=> 'present' })

  if ($my_wp::enable_main_wp){
		wordpress { $my_wp::main_wp_name:
		  install_dir     => "${my_wp::apache_docroot}/${my_wp::main_wp_name}",
		  create_db       => true,
		  create_db_user  => true,
		  db_name         => $my_wp::main_wp_name,
		  db_user         => $my_wp::main_wp_name,
      db_host         => 'localhost',
      db_password     => $my_wp::main_wp_db_pass,
      wp_owner        => $my_wp::wp_owner,
      wp_group        => $my_wp::wp_group,
		}
	}
	
	if ($my_wp::enable_cs_wp){
    wordpress { $my_wp::cs_wp_name :
      install_dir     => "${my_wp::apache_docroot}/${my_wp::cs_wp_name}",
      create_db       => true,
      create_db_user  => true,
      db_name         => $my_wp::cs_wp_name,
      db_user         => $my_wp::cs_wp_name,
      db_host         => 'localhost',
      db_password     => $my_wp::cs_wp_db_pass,
      wp_owner        => $my_wp::wp_owner,
      wp_group        => $my_wp::wp_group,
    }
  }
}
