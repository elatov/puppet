# == Class exim::aliases
#
# This class is called from exim::server::config or exim::client::config
#
define exim::aliases (
    $alias           = $title,
    $config_file,
    $alias_recipient, 
) {

  ensure_resource('file',$config_file,{ ensure => "present" })
 
	mailalias {$alias:
		ensure => "present",
		recipient => $alias_recipient,
		notify  => Exec["newalias-${alias}"],  
	}
	
	exec { "newalias-${alias}":
		path         => ["/bin/","/usr/bin"],
		command       => "newaliases",
		refreshonly   => true,
	}
}
