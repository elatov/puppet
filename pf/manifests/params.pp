# == Class pf::params
#
# This class is meant to be called from pf
# It sets variables according to platform
#
class pf::params {

	
	case $::osfamily {
		'FreeBSD': {
			$pf_package_name		= 'pf'
			$pf_service_name		= 'pf'
			## Dirs
			$pf_config_dir			= '/etc'
			$pf_service_dir			= '/etc/init.d'
			$pf_home						= '/etc/pf'
			
			### Files
			$pf_config_file			= 'pf.conf'
			$pf_rc_conf_file		= 'rc.conf'
			
			### Settings
      $default_pf_settings  = { 'pf_enable'      => 'YES',
                                'pf_rules'       => "${pf_home}/${pf_config_file}",
                                'pflog_enable'   => 'YES',
                                'pflog_logfile'  => '/var/log/pf.log'
                              }
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
}
