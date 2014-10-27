# == Class nfs::server::install
#
class nfs::server::install {

  ensure_packages ($nfs::server::package_name,{ 'ensure'=> 'present' })
}
