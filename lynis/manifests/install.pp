# == Class lynis::install
#
# This class is called from lynis for install.
#
class lynis::install {
  
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
