# == Class smartd::install
#
class smartd::install {

  if ($::operatingsystem == 'OmniOS') {
		pkg_publisher { 'uulm.mawi':
			origin  => 'http://scott.mathematik.uni-ulm.de/release',
			enable  => true,
			ensure  => 'present',
		}
    ensure_packages ($smartd::package_name,{ 'ensure'=> 'present', require => Pkg_publisher['uulm.mawi'] })
  } else {
    ensure_packages ($smartd::package_name,{ 'ensure'=> 'present' })
  }
}
