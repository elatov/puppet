class update_checker::config {
	file { $update_checker::cron_dir:
		ensure  => directory,
		owner   => 'root',
	}
  
  case $::osfamily {
    /(?i:RedHat)/: { 
        $update_checker_target_dir  = "/home/${update_checker::user}/.gdrive/notes/scripts/sh"

    }
    /(?i:Debian)/: { 
        $update_checker_target_dir  = "/home/${update_checker::user}/.gdrive/notes/scripts/csh"
    }
    /(?i:FreeBSD)/: { 
        $update_checker_target_dir  = "/home/${update_checker::user}/.gdrive/notes/scripts/bash"
    }
    default: {
        fail("The ${module_name} module is not supported on ${::osfamily}/${::operatingsystem}.")
    }
  }
  
  if ($::osfamily == 'FreeBSD'){
		file {"$update_checker::cron_dir/600.pkgng-check":
			ensure  => "link",
			target  => "${update_checker_target_dir}/${update_checker::update_script}",
			require => Class['grive']
		}
	} else {
		file {"$update_checker::cron_dir/$update_checker::update_script":
      ensure  => "link",
      target  => "${update_checker_target_dir}/${update_checker::update_script}",
      require => Class['grive']
    }
	}

}