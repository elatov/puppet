# == Class atomic::install
#
class atomic::install inherits atomic::params {

  ensure_resource ('file',
                   "/home/${atomic_user}/apps",
                   {'ensure'  => 'directory','owner'  => "${atomic_user}", 'group'  => "${atomic_user}"})
  
  file { $atomic_rpm_name:
    path    => "/home/elatov/apps/${atomic_rpm_name}",
    ensure  => "present",
    source  => "puppet:///modules/atomic/${atomic_rpm_name}",
  }
  
  package {'atomic-release':
    provider => 'rpm',
    source   => "/home/elatov/apps/${atomic_rpm_name}",
    ensure   => "present",
    require  => File ["/home/elatov/apps/${atomic_rpm_name}"]
  }
  
}
