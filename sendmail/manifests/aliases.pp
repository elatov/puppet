# == Class sendmail::aliases
#
# This class is called from sendmail::config
#
define sendmail::aliases (
    $alias           = $title,
    $config_file     = '/etc/aliases',
    $alias_recipient, 
) {

  ensure_resource('file',$config_file,{ ensure => "present" })
 
  mailalias {$alias:
    ensure => "present",
    recipient => $alias_recipient,
    notify  => Exec["newalias-${alias}"],  
  }
  
  exec { "newalias-${alias}":
    path         => ["/bin/","/usr/bin","/usr/sbin"],
    command       => "newaliases",
    refreshonly   => true,
  }
}
