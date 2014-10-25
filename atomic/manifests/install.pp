# == Class atomic::install
#
class atomic::install {

  ensure_resource ('file',
                   "/usr/local/apps",
                   {'ensure'  => 'directory',})
  
  file { $atomic::package_name:
    path    => "/usr/local/apps/${atomic::package_name}",
    ensure  => "present",
    source  => "puppet:///modules/atomic/${atomic::package_name}",
    require => File['/usr/local/apps'],
  }
  
  package {'atomic-release':
    provider => 'rpm',
    source   => "/usr/local/apps/${atomic::package_name}",
    ensure   => "present",
    require  => File ["/usr/local/apps/${atomic::package_name}"]
  }
  
}
