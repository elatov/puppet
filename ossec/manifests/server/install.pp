# == Class ossec::server::install
#
class ossec::server::install inherits ossec::params {

  ensure_resource ('package',$ossec_server_package_name,{ 'ensure'=> 'latest' })
}
