# == Class sendmail::config
#
# This class is called from sendmail
#
class sendmail::config {

  file { $sendmail::cf_dir:
    ensure  => 'directory',
  }
  
  file { $sendmail::mc_file:
    ensure  => 'present',
    path    => "${sendmail::cf_dir}/${sendmail::mc_file}",
    content => template("sendmail/${sendmail::mc_file}.erb"),
    require => File [$sendmail::cf_dir],
  }
}
