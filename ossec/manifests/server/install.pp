# == Class ossec::server::install
#
class ossec::server::install {

  ensure_resource ('package',$ossec::server::package_name,{ 'ensure'=> 'present' })
}
