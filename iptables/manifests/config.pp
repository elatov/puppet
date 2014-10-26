# == Class iptables::config
#
# This class is called from iptables
#
class iptables::config {
    
	file { $iptables::config_dir:
    ensure  => 'directory',
	}
  
  file { $iptables::config_file:
    ensure  => 'present',
    path    => "${iptables::config_dir}/${iptables::config_file}",
    source  => "puppet:///modules/iptables/${iptables::settings['host']}-iptables-conf",
    require => File [$iptables::config_dir],
    owner => root,
    group => root,
  }
}
