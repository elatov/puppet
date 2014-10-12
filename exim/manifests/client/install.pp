# == Class exim::client::install
#
class exim::client::install {

  ensure_resource ('package',$exim::client::package_name,{ 'ensure'=> 'present' })
}
