# == Class nfs::client::install
#
class nfs::client::install inherits nfs::params {

  ensure_resource ('package',$nfs_client_package_name,{ 'ensure'=> 'latest' })
}
