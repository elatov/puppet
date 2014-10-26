# == Class iptables::install
#
class iptables::install {

	if ($iptables::settings['remove_firewalld']) {
	 ensure_packages (firewalld,{ 'ensure'=> 'absent' })
	}
  
  ensure_packages ($iptables::package_name,{ 'ensure'=> 'present' })
}
