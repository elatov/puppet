# == Class newsyslog::install
#
class newsyslog::install {

  ensure_packages ($newsyslog::package_name,{ 'ensure'=> 'present' })
}
