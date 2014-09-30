# == Class my_mysql::install
#
class my_mysql::install {

  ensure_packages ($my_mysql::package_name,{ 'ensure'=> 'present' })
}
