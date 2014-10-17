# == Class smartd::install
#
class smartd::install {

  ensure_packages ($smartd::package_name,{ 'ensure'=> 'present' })
}
