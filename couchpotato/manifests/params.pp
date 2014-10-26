class couchpotato::params {
  
  $cp_settings_all          = { 'user'   => 'test'
                              }
  case $::osfamily {
    'Redhat': {
      ### Service
		  $cp_service_name        = 'couchpotato'
		  ## Dirs
		  $cp_install_dir         = '/usr/local/couchpotato'
		  $cp_config_dir          = '/etc/sysconfig'
		  ### Conf File
		  $cp_settings_file       = 'settings.conf'
		  ## settings
		  $cp_settings_os         = {'pkgs_pre'       => ['git','python'],
		                             'initial_setup'  => true,
		                            }
		  
  
		  if $::operatingsystemmajrelease >= 7 {
		    $cp_service_file      = 'couchpotato.service'
		    $cp_service_dir       = '/usr/lib/systemd/system'
		  }else{
		    $cp_service_file      = 'couchpotato.init'
		    $cp_config_file       = 'couchpotato.sysconf'
		    $cp_service_dir       = '/etc/init.d'
		  }
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }
  $cp_default_settings = merge($cp_settings_all,$cp_settings_os)
}
