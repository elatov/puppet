# == Class grive::install
#
class grive::install  {

  ensure_packages ($grive::settings['pre_pkgs'],{ 'ensure'=> 'present' })
  
	ensure_resource ('file',
                   "/home/${grive::settings['user']}/apps",
                   {'ensure'  => 'directory','owner'  => "${grive::settings['user']}",'group'  => "${grive::settings['user']}"})
                   
  file { $grive::settings['home_dir']:
    ensure => 'directory',
  }    
	# let's get the TAR archive from the puppet master
	file {"get-${grive::package_name}":
		ensure => 'present',
		path   => "/home/${grive::settings['user']}/apps/${grive::package_name}",
		source => "puppet:///modules/grive/${grive::package_name}",
		require => File ["/home/${grive::settings['user']}/apps"], 
	}~>	
	# extract the TAR
	exec {"install-$grive::package_name":
    command     => "tar xjf /home/${grive::settings['user']}/apps/${grive::package_name} -C ${grive::settings['home_dir']}",
    provider    => "shell",
    refreshonly => true,
    creates     => "${grive::settings['home_dir']}/bin/grive",
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
