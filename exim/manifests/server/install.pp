# == Class exim::server::install
#
class exim::server::install {

  ensure_packages ($exim::server::package_name,{ 'ensure'=> 'present' })
}
