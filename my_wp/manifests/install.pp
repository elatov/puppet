# == Class my_wp::install
#
class my_wp::install {

  ensure_packages ($my_wp::package_name,{ 'ensure'=> 'present' })
}
