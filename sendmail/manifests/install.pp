# == Class sendmail::install
#
class sendmail::install {

  ensure_packages ($sendmail::package_name,{ 'ensure'=> 'present' })
  
  if ($sendmail::settings['enable_smtp_notify']){
    ensure_packages ('smtp-notify',{ 'ensure'=> 'present' })
  }
}
