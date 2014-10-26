# == Class nfs::server::install
#
class nfs::server::install inherits nfs::params {

  ensure_packages ($nfs_server_package_name,{ 'ensure'=> 'latest' })
}
