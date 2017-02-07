# == Class lynis::install
#
# This class is called from lynis for install.
#
class lynis::install {
  
  case $::osfamily {
    'Debian': {
      if ( $::lynis::settings['apt_repo_enabled'] == true ){
				apt::source { 'lynis':
					location   => "https://packages.cisofy.com/community/lynis/deb/",
					release    => 'jessie',
					repos      => 'main',
					key        => {
					               'id'      => 'C80E383C3DE9F082E01391A0366C67DE91CA5D5F',
					               'server'  => 'keyserver.ubuntu.com',
					              }
				}
      }

      ensure_resource ('package',$::lynis::package_name,{ 'ensure'  => 'present',
                                                          'require' => Apt::Source['lynis'] 
                                                        }
                      )
    }
    'RedHat': {
      if ( $::lynis::settings['yum_repo_enabled'] == true ){
		    yumrepo  { lynis :
		                 baseurl   => "https://packages.cisofy.com/community/lynis/rpm/",
		                 descr     => "CISOfy Software - Lynis package",
		                 enabled   => 1,
		                 gpgcheck  => 1,
		                 gpgkey    => "https://packages.cisofy.com/keys/cisofy-software-rpms-public.key",
		             }
      }

			ensure_resource ('package',$::lynis::package_name,{ 'ensure'  => 'present',
			                                                    'require' => Yumrepo['lynis'] 
			                                                  }
			                )
    }
    'FreeBSD': {
      ensure_resource ('package',$::lynis::package_name,{ 'ensure'  => 'present',})
    }
    default: {
      fail("${::operatingsystem} not supported")
    }  
  }
  
  
}
