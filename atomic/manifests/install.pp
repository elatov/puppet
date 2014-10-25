# == Class atomic::install
#
class atomic::install {

  ensure_resource ('file',
                   "${atomic::user_home_dir}/apps",
                   {'ensure'  => 'directory',
                    'owner'  => "${atomic::settings['user']}", 
                    'group'  => "${atomic::settings['user']}"})
  
  file { $atomic::package_name:
    path    => "${atomic::user_home_dir}/apps/${atomic::package_name}",
    ensure  => "present",
    source  => "puppet:///modules/atomic/${atomic::package_name}",
    require => File["${atomic::user_home_dir}/apps"],
  }
  
  package {'atomic-release':
    provider => 'rpm',
    source   => "${atomic::user_home_dir}/apps/${atomic::package_name}",
    ensure   => "present",
    require  => File ["${atomic::user_home_dir}/apps/${atomic::package_name}"]
  }
  
}
