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
    require => File[$sendmail::cf_dir],
  }~>
  exec { "${module_name}-m4-gen-sm-config":
    cwd         => $sendmail::cf_dir,
    command     => "/usr/ccs/bin/m4 ../m4/cf.m4 sm.mc > sm.cf",
    creates     => "${sendmail::cf_dir}/sm.cf",
    refreshonly => true,
  }~>
	exec { "${module_name}-cp-${sendmail::config_file}":
		command     => "/usr/bin/cp ${sendmail::cf_dir}/sm.cf ${sendmail::config_dir}/${sendmail::config_file}",
		onlyif      => "/usr/sbin/sendmail -C ${sendmail::cf_dir}/sm.cf -v root < /dev/null |  /usr/bin/grep 'go ahead'",
		refreshonly => true,
	}
	
	logadm {'/var/adm/mail.log':
		count => '3',
		post_command => "kill -HUP `cat /var/run/syslog.pid`"
	}
	if ($sendmail::settings['aliases']){
		sendmail::aliases{ $sendmail::settings['aliases']:
		  alias_recipient => $sendmail::settings['alias_recipient'],
		}
	}
	
	if ($sendmail::settings['enable_smtp_notify']){
    exec { "${module_name}-enable-smtp-notify-mainten-service" :
      command => '/usr/sbin/svccfg setnotify -g to-maintenance mailto:$root',
      unless  => '/usr/sbin/svccfg listnotify -g | /bin/grep to-maintenance',
    }
  }
}
