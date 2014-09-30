# == Class my_mysql::client::install
#
class my_mysql::client::install {

  ensure_resource ('package',$my_mysql::client_package_name,{ 'ensure'=> 'present' })
}
