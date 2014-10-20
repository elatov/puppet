# == Class grive::install
#
class grive::install  {

  if ($::operatingsystem == 'OmnioS'){
    ensure_packages ($grive::settings['pre_pkgs'],{ 'ensure'=> 'present' })
    ensure_packages ($grive::settings['pre_pkgin'],{ 'provider' => 'pkgin','ensure'=> 'present' })
  }else{
    ensure_packages ($grive::settings['pre_pkgs'],{ 'ensure'=> 'present' })
  }
  
  $var  = "home_${settings['user']}"
  $user_home_dir = inline_template("<%= scope.lookupvar('::$var') %>")
  
	ensure_resource ('file',
                   "${$user_home_dir}/apps",
                   {'ensure' => 'directory',
                    'owner'  => "${grive::settings['user']}",
                    'group'  => "${grive::settings['user']}"})
                   
  file { $grive::settings['home_dir']:
    ensure => 'directory',
  }    
	# let's get the TAR archive from the puppet master
	file {"get-${grive::package_name}":
		ensure => 'present',
		path   => "${user_home_dir}/apps/${grive::package_name}",
		source => "puppet:///modules/grive/${grive::package_name}",
		require => File ["${user_home_dir}/apps"], 
	}~>	
	# extract the TAR
	exec {"install-$grive::package_name":
    command     => "tar xjf ${user_home_dir}/apps/${grive::package_name} -C ${grive::settings['home_dir']}",
    provider    => "shell",
    refreshonly => true,
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
