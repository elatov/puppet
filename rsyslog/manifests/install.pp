class rsyslog::install {
  
  ensure_packages($rsyslog::package_name,{ensure => 'present'})
}