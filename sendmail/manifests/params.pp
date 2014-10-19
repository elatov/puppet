# == Class sendmail::params
#
# This class is meant to be called from sendmail
# It sets variables according to platform
#
class sendmail::params {

	$sendmail_settings_all	=	{ 'smart_relayhost' => $::hostname,
                              'aliases'         => ['root','test'],
                              'alias_recipient' => 'root'
										        }
	case $::osfamily {
		'Solaris': {
		  ### Package
			$sendmail_package_name		= 'sendmail'
			### Service
			$sendmail_service_name		= 'sendmail'
			### Dirs
			$sendmail_config_dir			= '/etc/mail'
			$sendmail_cf_dir          = "${sendmail_config_dir}/cf/cf"
			### Conf Files
			$sendmail_config_file			= 'sendmail.cf'
			$sendmail_mc_file         = 'sm.mc'
			### Settings
			$sendmail_settings_os		  = { }
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$sendmail_default_settings = merge($sendmail_settings_all,$sendmail_settings_os)
}
