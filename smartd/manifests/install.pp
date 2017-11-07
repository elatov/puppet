# == Class smartd::install
#
class smartd::install {

  if ($::operatingsystem == 'OmniOS') {
		pkg_publisher { 'cs.umd.edu':
			origin  => 'http://pkg.cs.umd.edu/',
			enable  => true,
			ensure  => 'present',
		}
    ensure_packages ($smartd::package_name,{ 'ensure'=> 'present', require => Pkg_publisher['cs.umd.edu'] })
  } else {
    ensure_packages ($smartd::package_name,{ 'ensure'=> 'present' })
  }
}
