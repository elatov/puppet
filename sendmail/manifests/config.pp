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
  }->
  exec { "${module_name}-m4-gen-sm-config":
    cwd     => $sendmail::cf_dir,
    command => "/usr/ccs/bin/m4 ../m4/cf.m4 sm.mc > sm.cf",
    creates => "${sendmail::cf_dir}/sm.cf",
  }
}
