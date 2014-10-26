# == Class iptables::params
#
# This class is meant to be called from iptables
# It sets variables according to platform
#
class iptables::params {

	$iptables_settings	=	{'remove_firewalld'   => false,
										     'host'	              => $::hostname,
										    }
	case $::operatingsystem {
    /(?i:CentOS|fedora)/: { 
      if ($::operatingsystemmajrelease == '7') { 
        $iptables_package_name                  = 'iptables-services'
        $iptables_config_dir                    = '/etc/sysconfig'
        $iptables_config_file                   = 'iptables'
        $iptables_service_name                  = 'iptables'
        $iptables_settings['remove_firewalld']  = true
        
      } else { 
        $iptables_package_name                  = 'iptables'
        $iptables_config_dir                    = '/etc/sysconfig'
        $iptables_config_file                   = 'iptables'
        $iptables_service_name                  = 'iptables'

      }
    }
    /(?i:Debian|Ubuntu)/: {
			$iptables_package_name                  = 'iptables-persistent'
			$iptables_config_dir                    = '/etc/iptables/'
			$iptables_config_file                   = 'rules.v4'
			$iptables_service_name                  = 'iptables-persistent'
 
    }
    default: {
			$iptables_package_name                  = 'iptables'
			$iptables_config_dir                    = '/etc/sysconfig'
			$iptables_config_file                   = 'iptables'
			$iptables_service_name                  = 'iptables'
    }
  }

}
