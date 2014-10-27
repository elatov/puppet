# == Class nfs::client::install
#
class nfs::client::install{

  ensure_resource ('package',$nfs::client::package_name,{ 'ensure'=> 'latest' })
}
