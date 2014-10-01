# == Class my_mysql::config
#
# This class is called from my_mysql
#
class my_mysql::config {
  
#  file { $my_mysql::config_dir:
#    ensure  => 'directory',
#  }
#  
#  file { $my_mysql::config_file:
#    ensure  => 'present',
#    path    => "${my_mysql::config_dir}/${my_mysql::config_file}",
#    source => "puppet:///modules/my_mysql/${my_mysql::config_file}",
#    require => File [$my_mysql::config_dir],
#  }
}
