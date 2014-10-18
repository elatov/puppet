# == Class smartd::install
#
class smartd::install {

  if ($::operatingsystem == 'OmniOS') {
		pkg_publisher { 'ms.omniti.com':
			origin  => 'http://pkg.omniti.com/omniti-ms',
			enable  => true,
			ensure  => 'present',
		}
    ensure_packages ($smartd::package_name,{ 'ensure'=> 'present', require => Pkg_publisher['ms.omniti.com'] })
  } else {
    ensure_packages ($smartd::package_name,{ 'ensure'=> 'present' })
  }
}
