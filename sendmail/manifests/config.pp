# == Class sendmail::config
#
# This class is called from sendmail
#
class sendmail::config {

  file { $sendmail::config_dir:
    ensure  => 'directory',
  }
  
  file { $sendmail::config_file:
    ensure  => 'present',
    path    => "${sendmail::config_dir}/sendmail",
    content => template("sendmail/${sendmail::config_file}.erb"),
    require => File [$sendmail::config_dir],
  }
}
