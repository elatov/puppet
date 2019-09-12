# == Class drive::params
#
# This class is meant to be called from drive
# It sets variables according to platform
#
class drive::params {
	$drive_settings_all	 =	{ 'user' 	   => 'test',
	                          'host'     => $::hostname,
	                          'home_dir' => '/usr/local'
										      }
  
  case $::operatingsystem {
    'OmniOS': {
			$drive_package_name  = "drive-${::operatingsystem}-${::operatingsystemrelease}-${::hardwaremodel}.tar.bz2"
		}
		'FreeBSD': {
      $drive_package_name  = "drive-${::operatingsystem}-${::kernelmajversion}-${::hardwaremodel}.tar.bz2"
    }
    default:{
      $drive_package_name  = "drive-${::operatingsystem}-${::operatingsystemmajrelease}-${::hardwaremodel}.tar.bz2"
    }
  }
  # if ($::operatingsystem == "OmniOS"){
	#  $drive_package_name  = "drive-${::operatingsystem}-${::operatingsystemrelease}-${::hardwaremodel}.tar.bz2"
	# }else{
	# $drive_package_name  = "drive-${::operatingsystem}-${::operatingsystemmajrelease}-${::hardwaremodel}.tar.bz2"
	# }
	$drive_initial_setup = false
	
	case $::osfamily {
    'Archlinux': {
			$drive_settings_os  = {'pre_pkgs' => ['go',
                                           ],
                            }
		}
		'Debian': {

      case $::operatingsystem {
          'ubuntu': {
            $drive_settings_os  = {}
          }
          'debian': {
            $drive_settings_os  = {'pre_pkgs' => ['libboost-program-options1.49.0',
                                            'libboost-filesystem1.49.0',
                                            'libyajl2',
                                            'libboost-test1.49.0'],
                            }
          }
        }

		}
		'RedHat': {
			$drive_settings_os  = {'pre_pkgs' => ['boost-program-options',
                                            'boost-filesystem',
                                            'yajl',
                                            'boost-test'],
                            }
			
			
			
		}
		'FreeBSD': {
      $drive_settings_os  = {'pre_pkgs' => ['boost-libs',
                                            'yajl',
                                            'curl',
                                            'json-c',
                                            'libgcrypt',
                                            'libgpg-error'],
                            }
    }
    'Solaris': {
      $drive_settings_os  = {'pre_pkgs'  => [ 'boost',
                                              'libgcrypt',
                                              'yajl',
                                              'json-c',
                                              'curl',
                                              'gcc47',
                                              'expat',
                                             ]
                            }
    }
		default: {
			fail("${::operatingsystem} not supported")
		}
	}
	$drive_default_settings = merge($drive_settings_all,$drive_settings_os)
}
