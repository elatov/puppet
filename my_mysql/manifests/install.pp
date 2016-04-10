# == Class my_mysql::install
#
class my_mysql::install {

  Package <| title == 'mysql-server' |> {
      name => 'mariadb-server',
    }
    Package <| title == 'mysql_client' |> {
      name => 'mariadb-client',
    }
	class { '::mysql::server':
		root_password           => $my_mysql::settings['root_password'],
		manage_config_file      => false,
		remove_default_accounts => true,
		package_name            => $my_mysql::package_name,
	}
}
