class update_checker::config {
  
  if ($update_checker::cron_dir != undef){
		file { $update_checker::cron_dir:
			ensure  => directory,
			owner   => 'root',
		}
	}
  
  case $::osfamily {
    /(?i:RedHat)/: { 
        $update_checker_target_dir  = "${update_checker::user_home_dir}/.gdrive/notes/scripts/sh"

    }
    /(?i:Debian)/: { 
        $update_checker_target_dir  = "${update_checker::user_home_dir}/.gdrive/notes/scripts/csh"
    }
    /(?i:FreeBSD)/: { 
        $update_checker_target_dir  = "${update_checker::user_home_dir}/.gdrive/notes/scripts/bash"
    }
     /(?i:Solaris)/: {
      ensure_resource ('file','/usr/local/bin/',{ 'ensure' => 'directory'})

			file {"/usr/local/bin/${update_checker::update_script}":
				ensure  => "link",
				target  => "${update_checker::user_home_dir}/.gdrive/notes/scripts/bash/${update_checker::update_script}",
				require => [Class['drive'],File['/usr/local/bin']],
			}
			
			file {"/usr/local/bin/pkgin-check.bash":
        ensure  => "link",
        target  => "${update_checker::user_home_dir}/.gdrive/notes/scripts/bash/pkgin-check.bash",
        require => [Class['drive'],File['/usr/local/bin']],
      } 
      
			cron {"pkg-check":
				command => "/usr/local/bin/$update_checker::update_script",
				user => "root",
				minute => "30",
				hour   => "00",
				require => Class['drive'],
			}
			cron {"pkgin-check":
				command => "/usr/local/bin/pkgin-check.bash",
				user => "root",
				minute => "00",
				hour   => "01",
				require => Class['drive'],
			}
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
	} elsif ( $::osfamily =~ /(?i:RedHat|Debian)/ ) {
		file {"$update_checker::cron_dir/$update_checker::update_script":
      ensure  => "link",
      target  => "${update_checker_target_dir}/${update_checker::update_script}",
      require => Class['drive']
    }
	}

}