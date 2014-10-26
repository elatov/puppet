# == Class iptables::params
#
# This class is meant to be called from iptables
# It sets variables according to platform
#
class iptables::params {

	$iptables_settings_all	=	{ 'remove_firewalld'   => false,
										          'host'	             => $::hostname,
										        }
	case $::operatingsystem {
    /(?i:CentOS|fedora)/: { 
      if ($::operatingsystemmajrelease == '7') {
        ## Package 
        $iptables_package_name    = 'iptables-services'
        ## Service
        $iptables_service_name    = 'iptables'
        ## Dirs
        $iptables_config_dir      = '/etc/sysconfig'
        ## Conf Files
        $iptables_config_file     = 'iptables'
        ## Settings
        $iptables_settings_os     =  { 'remove_firewalld' => true }
        
      } else { 
        $iptables_package_name    = 'iptables'
        $iptables_config_dir      = '/etc/sysconfig'
        $iptables_config_file     = 'iptables'
        $iptables_service_name    = 'iptables'

      }
    }
    /(?i:Debian|Ubuntu)/: {
			$iptables_package_name       = 'iptables-persistent'
			$iptables_config_dir         = '/etc/iptables/'
			$iptables_config_file        = 'rules.v4'
			$iptables_service_name       = 'iptables-persistent'
 
    }
    default: {
			$iptables_package_name       = 'iptables'
			$iptables_config_dir         = '/etc/sysconfig'
			$iptables_config_file        = 'iptables'
			$iptables_service_name       = 'iptables'
    }
  }
  $iptables_default_settings = merge($iptables_settings_all,$iptables_settings_os)
}
