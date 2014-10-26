class couchpotato::params {
  $cp_install_dir = "/usr/local/couchpotato"
  $cp_user = "test"
  
  if $::operatingsystemmajrelease >= 7 {
    $cp_service_file = "couchpotato.service"
  }else{
    $cp_service_file = "couchpotato.init"
    $cp_sys_config_file      = "couchpotato.sysconf"
  }

  $cp_service_name         = "couchpotato"
  $cp_settings_file        = "settings.conf"
}
