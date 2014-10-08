# == Class pf::install
#
class pf::install {

  ensure_packages ($pf::package_name,{ 'ensure'=> 'present' })
}
