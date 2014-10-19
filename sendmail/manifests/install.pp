# == Class sendmail::install
#
class sendmail::install {

  ensure_packages ($sendmail::package_name,{ 'ensure'=> 'present' })
}
