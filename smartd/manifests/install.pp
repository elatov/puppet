# == Class smartd::install
#
class smartd::install {

  if ($::operatingsystem =~ /(?i:OmniOS|Solaris)/) {
        $string = split($::kernelversion,/-/)
        #notify { "$::kernelversion":
        #   message => "$string"
        #}
        $omnios_release = $string[1]
    pkg_publisher { 'extra.omnios':
      origin  => "https://pkg.omniosce.org/${omnios_release}/extra",
      enable  => true,
      ensure  => 'present',
    }
    ensure_packages ($smartd::package_name,{ 'ensure'=> 'present', require => Pkg_publisher['extra.omnios'] })
  } else {
    ensure_packages ($smartd::package_name,{ 'ensure'=> 'present' })
  }
}
