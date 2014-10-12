class update_checker::config {
	file { $update_checker::cron_dir:
		ensure  => directory,
		owner   => 'root',
	}
  
  if ($::osfamily == 'FreeBSD'){
		file {"$update_checker::cron_dir/600.pkgng-check":
			ensure  => "link",
			target  => "$update_checker::target_dir/$update_checker::update_script",
			require => Class['grive']
		}
	} else {
		file {"$update_checker::cron_dir/$update_checker::update_script":
      ensure  => "link",
      target  => "$update_checker::target_dir/$update_checker::update_script",
      require => Class['grive']
    }
	}

}