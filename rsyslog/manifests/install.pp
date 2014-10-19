class rsyslog::install {
  if $::osfamily !~ /(?i:FreeBSD|Solaris)/ {
    ensure_packages($rsyslog::package_name,{ensure => 'present'})
  }
}