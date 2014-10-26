# See README.md for further information on usage.
class transmission::params {

  $transmission_server_settings_all = { 'user' => 'test'}
  $transmission_client_settings_all = { 'user' => 'test'}
  
  case $::osfamily {
    'Redhat': {
      ### Server
      ## Package
      $transmission_server_package_name          = 'transmission-daemon'
      
      ### Service
      $transmission_server_service_name          = 'transmission-daemon'
      
      ### Dirs
      $transmission_server_config_dir            = '/var/lib/transmission/.config'
		  $transmission_server_log_dir               = '/var/log/transmission'
		  
      ### Config Files
      $transmission_server_config_file           = 'settings.json'
      $transmission_server_service_file          = 'transmission-daemon.service'
      $transmission_server_log_file              = 'transmission.log'
      
      ### Settings
      $transmission_server_settings_os           = { 'initial_setup'  => true }
      
      if $::operatingsystemmajrelease >= 7 {
        $transmission_server_service_dir         = '/usr/lib/systemd/system'
      }else{
        $transmission_server_service_dir         = '/etc/init.d'
      }
      
      ### Client
      ## Package
      ## Service
      ## Dirs
      ## Config Files
      ## Settings
      $transmission_client_settings_os           = {}
      
    }
    'Debian': {
      $transmission_server_config_dir            = '/var/lib/transmission/.config'
      $transmission_server_package_name          = 'transmission-daemon'
      $transmission_server_service_name          = 'transmission-daemon'
      $transmission_service_file                 = 'transmission-daemon.init'
      $transmission_server_service_dir           = '/etc/init.d'
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }
  $transmission_client_default_settings = merge($transmission_client_settings_all,$transmission_client_settings_os)
  $transmission_server_default_settings = merge($transmission_server_settings_all,$transmission_server_settings_os)
}