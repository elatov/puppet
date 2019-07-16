# == Class iptables::params
#
# This class is meant to be called from iptables
# It sets variables according to platform
#
class iptables::params {

	$iptables_settings_all	=	{ 'host'  => $::hostname,
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
        $iptables_settings_os     =  { }

      }
    }
    /(?i:Debian|Ubuntu)/: {
      if ($::operatingsystemmajrelease == '10') {
			 $iptables_package_name       = 'netfilter-persistent'
			 $iptables_service_name       = 'netfilter-persistent'
			} else {
			 $iptables_package_name       = 'iptables-persistent'
       $iptables_service_name       = 'iptables-persistent'
			} 
			
			$iptables_config_dir         = '/etc/iptables/'
			$iptables_config_file        = 'rules.v4'
      $iptables_settings_os     =  { }
 
    }
    default: {
			$iptables_package_name       = 'iptables'
			$iptables_config_dir         = '/etc/sysconfig'
			$iptables_config_file        = 'iptables'
			$iptables_service_name       = 'iptables'
      $iptables_settings_os     =  { }
    }
  }
  $iptables_default_settings = merge($iptables_settings_all,$iptables_settings_os)
}
