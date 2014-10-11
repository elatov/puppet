class rsyslog::install {
  if ($::osfamily != 'FreeBSD'){
    ensure_packages($rsyslog::package_name,{ensure => 'present'})
  }
}