# == Class my_mysql::server::install
#
class my_mysql::server::install {

  ensure_packages ($my_mysql::server::package_name,{ 'ensure'=> 'present' })
}
