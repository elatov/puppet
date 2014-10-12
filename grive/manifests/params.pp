# == Class grive::params
#
# This class is meant to be called from grive
# It sets variables according to platform
#
class grive::params {
	$grive_settings_all	 =	{ 'user' 	   => 'test',
	                          'host'     => $::hostname,
	                          'home_dir' => '/usr/local'
										      }

	$grive_package_name  = "grive-${::operatingsystem}-${::operatingsystemmajrelease}-${::hardwaremodel}.tar.bz2"
	$grive_initial_setup = false
	
	case $::osfamily {
		'Debian': {
			
			$grive_settings_os  = {'pre_pkgs' => ['libboost-program-options1.49.0',
                                            'libboost-filesystem1.49.0',
                                            'libyajl2',
                                            'libboost-test1.49.0'],
                            }

		}
		'RedHat': {
			$grive_settings_os  = {'pre_pkgs' => ['boost-program-options',
                                            'boost-filesystem',
                                            'yajl',
                                            'boost-test'],
                            }
			
			
			
		}
		'FreeBSD': {
      $grive_settings_os  = {'pre_pkgs' => ['boost-libs',
                                            'yajl',],
                            }
      
      
      
    }
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$grive_default_settings = merge($grive_settings_all,$grive_settings_os)
}
