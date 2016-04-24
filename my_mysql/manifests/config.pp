# == Class my_mysql::config
#
# This class is called from my_mysql
#
class my_mysql::config {
  
	case $::osfamily {
		'Debian': {	  
			#file { $my_mysql::config_dir:
			# ensure  => 'directory',
			#}
			
			file { $my_mysql::config_file:
				ensure  => 'present',
				owner   => 'root',
				group   => 'root',
				mode    => '0644',
				path    => "${my_mysql::config_dir}/${my_mysql::config_file}",
				source => "puppet:///modules/my_mysql/${my_mysql::config_file}",
				require => File[$my_mysql::config_dir],
			}
		}
		'FreeBSD': {
			file { $my_mysql::config_dir:
			 ensure  => 'directory',
			}
			
			file { $my_mysql::config_file:
				ensure  => 'present',
				owner   => 'root',
				group   => 'wheel',
				mode    => '0644',
				path    => "${my_mysql::config_dir}/${my_mysql::config_file}",
				source => "puppet:///modules/my_mysql/${my_mysql::config_file}",
				require => File[$my_mysql::config_dir],
			}
		}
	}
}
