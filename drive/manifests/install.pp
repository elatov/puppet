# == Class drive::install
#
class drive::install  {

#  if ($::operatingsystem == 'OmniOS'){
#    ensure_packages ($drive::settings['pre_pkgs'],{ 'provider' => 'pkgin',
#                                                    'ensure'   => 'present',
#                                                    'require'  => Class['pkgsrc'] })
#  }else{
#    ensure_packages ($drive::settings['pre_pkgs'],{ 'ensure'=> 'present' })
#  }
  
  ensure_resource ('user',$drive::settings['user'],{ 'ensure'=> 'present' })  
  ensure_resource ('file',
                   '/usr/local/apps',
                   {'ensure' => 'directory',})
                   
  ensure_resource ('file',
                   $drive::settings['home_dir'],
                   {'ensure' => 'directory',})

	# let's get the TAR archive from the puppet master
	file {"get-${drive::package_name}":
		ensure => 'present',
		path   => "/usr/local/apps/${drive::package_name}",
		source => "puppet:///modules/drive/${drive::package_name}",
#    source => "/tmp/vagrant-puppet-3/modules-0/drive/files/${drive::package_name}",
		require => File['/usr/local/apps'], 
	}
	# extract the TAR
	exec {"install-$drive::package_name":
    command     => "tar xjf /usr/local/apps/${drive::package_name} -C ${drive::settings['home_dir']}",
    provider    => "shell",
#    creates     => "${drive::settings['home_dir']}/drive/bin/drive",
    subscribe   => File["get-${drive::package_name}"],
    refreshonly => true,
    require     => File[$drive::settings['home_dir']],
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
