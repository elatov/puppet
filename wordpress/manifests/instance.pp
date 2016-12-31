define wordpress::instance (
  $install_dir    = $title,
  $doc_root       = '/opt',
  $download_url   = 'http://wordpress.org',
  $version        = 'latest',
  $wp_owner       = 'root',
  $wp_group       = '0',
  $settings       = undef,    
) {
  validate_string($install_dir, $download_url, $version, $wp_owner,
                  $wp_group, $doc_root
                  )
  validate_absolute_path('${doc_root}/${install_dir}')
  validate_hash($settings)
  
  ## Resource defaults
	File {
		owner  => $wp_owner,
		group  => $wp_group,
		mode   => '0644',
	}
	Exec {
		path      => ['/bin','/sbin','/usr/bin','/usr/sbin'],
		cwd       => "${doc_root}/${install_dir}",
		logoutput => 'on_failure',
	}

  ## Installation directory
	file { "${doc_root}/${install_dir}":
	 ensure  => directory,
	}

  ## Download and extract
  exec { "download_wp_tar-${install_dir}":
    command => "wget ${download_url}/wordpress-${version}.tar.gz",
    creates => "${doc_root}/${install_dir}/wordpress-${version}.tar.gz",
    require => File["${doc_root}/${install_dir}"],
    user    => $wp_owner,
    group   => $wp_group,
  }
  -> exec { "extract_wordpress_${install_dir}":
    command => "tar zxvf ./wordpress-${version}.tar.gz --strip-components=1",
    creates => "${doc_root}/${install_dir}/index.php",
    user    => $wp_owner,
    group   => $wp_group,
  }
  ~> exec { "chown_${install_dir}":
    command     => "chown -R ${wp_owner}:${wp_group} ${doc_root}/${install_dir}",
    refreshonly => true,
    user        => $wp_owner,
    group       => $wp_group,
  }

  ## Configure wordpress
  #
  concat { "${doc_root}/${install_dir}/wp-config.php":
    owner   => $wp_owner,
    group   => $wp_group,
    mode    => '0755',
    require => Exec["extract_wordpress_${install_dir}"],
  }

  # Template uses no variables
  file { "${doc_root}/${install_dir}/wp-keysalts.php":
    ensure  => present,
    content => template('wordpress/wp-keysalts.php.erb'),
    replace => false,
    require => Exec["extract_wordpress_${doc_root}/${install_dir}"],
  }
  concat::fragment { "${doc_root}/${install_dir}/wp-config.php keysalts":
    target  => "${doc_root}/${install_dir}/wp-config.php",
    source  => "${doc_root}/${install_dir}/wp-keysalts.php",
    order   => '10',
    require => File["${doc_root}/${install_dir}/wp-keysalts.php"],
  }
  # Template uses:
  # - $db_name
  # - $db_user
  # - $db_password
  # - $db_host
  # - $wp_table_prefix
  # - $wp_proxy_host
  # - $wp_proxy_port
  # - $wp_additional_config
  concat::fragment { "${doc_root}/${install_dir}/wp-config.php body":
    target  => "${doc_root}/${install_dir}/wp-config.php",
    content => template('wordpress/wp-config.php.erb'),
    order   => '20',
  }
  
  ### Configure the DB
  ## Set up DB using puppetlabs-mysql defined type
  if $settings['wp_db_settings']['create_db'] {
    mysql_database { "$settings['wp_db_settings']['db_host']/$settings['wp_db_settings']['db_name']":
      name => $settings['wp_db_settings']['db_name'],
      charset => 'utf8',
    }
  }
  if $settings['wp_db_settings']['create_db_user'] {
    mysql_user { "$settings['wp_db_settings']['db_user']@$settings['wp_db_settings']['db_host']":
      password_hash => mysql_password($settings['wp_db_settings']['db_password']),
    }
    mysql_grant { "$settings['wp_db_settings']['db_user']@$$settings['wp_db_settings']['db_host']/$settings['wp_db_settings']['db_name'].*":
      table      => "$settings['wp_db_settings']['db_name'].*",
      user       => "$settings['wp_db_settings']['db_user']@$settings['wp_db_settings']['db_host']",
      privileges => ['ALL'],
    }
  }
  
  ### Configure Apache config
  if $settings['wp_web_settings']['apache_conf_enabled'] {
	  file { "$settings['wp_web_settings']['apache_config_dir']/$settings['wp_web_settings']['apache_config_file']":
	      ensure  => 'present',
	      content  => template("wordpress/apache-conf.erb"),
	    }
  }
}