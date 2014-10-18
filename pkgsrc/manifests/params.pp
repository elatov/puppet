# == Class pkgsrc::params
#
# This class is meant to be called from pkgsrc
# It sets variables according to platform
#
class pkgsrc::params {

	$pkgsrc_default_settings	=	{	'version' 	=> '2014Q2',
	                              'url'       => 'pkgsrc.joyent.com/packages/SmartOS/bootstrap',
                                'upgrade'   => false,
										          }
	case $::osfamily {
		'Solaris': {
			$pkgsrc_home						= '/opt/local'
			$pkgsrc_settings_os		= { }
		}
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$pkgsrc_default_settings = merge($pkgsrc_default_settings,$pkgsrc_settings_os)
}
