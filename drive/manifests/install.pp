# == Class grive::install
#
class grive::install  {

  if ($::operatingsystem == 'OmniOS'){
    ensure_packages ($grive::settings['pre_pkgs'],{ 'provider' => 'pkgin',
                                                    'ensure'   => 'present',
                                                    'require'  => Class['pkgsrc'] })
  }else{
    ensure_packages ($grive::settings['pre_pkgs'],{ 'ensure'=> 'present' })
  }
  
  ensure_resource ('user',$grive::settings['user'],{ 'ensure'=> 'present' })  
  ensure_resource ('file',
                   '/usr/local/apps',
                   {'ensure' => 'directory',})
                   
  ensure_resource ('file',
                   $grive::settings['home_dir'],
                   {'ensure' => 'directory',})

	# let's get the TAR archive from the puppet master
	file {"get-${grive::package_name}":
		ensure => 'present',
		path   => "/usr/local/apps/${grive::package_name}",
		source => "puppet:///modules/grive/${grive::package_name}",
#    source => "/tmp/vagrant-puppet-3/modules-0/grive/files/${grive::package_name}",
		require => File ['/usr/local/apps'], 
	}->
	# extract the TAR
	exec {"install-$grive::package_name":
    command     => "tar xjf /usr/local/apps/${grive::package_name} -C ${grive::settings['home_dir']}",
    provider    => "shell",
    creates     => "${grive::settings['home_dir']}/grive/bin/grive",
    require     => File[$grive::settings['home_dir']],
	}
	
# Old way to sync everything from the puppet master, was too cpu intensive
#	file{"/home/${grive_settings['user']}/.gdrive":
#    ensure  => 'directory',
#    recurse => true,
#    links   => "follow",
#    owner   => $grive_settings['user'],
#    group   => $grive_settings['user'],
#    source  => "puppet:///modules/grive/.gdrive",
#	}

}
