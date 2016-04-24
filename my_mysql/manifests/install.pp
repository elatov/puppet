# == Class my_mysql::install
#
class my_mysql::install {

	class { '::mysql::server':
		root_password           => $my_mysql::settings['root_password'],
		manage_config_file      => false,
		remove_default_accounts => true,
		package_name            => $my_mysql::package_name,
		override_options        => $my_mysql::settings['default_override'],
	}
	class { '::mysql::client':
    package_name            => 'mariadb100-client',
  }
}
