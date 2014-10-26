class couchpotato (
  $install_dir          = $couchpotato::params::cp_install_dir,
  $user                 = $couchpotato::params::cp_user,
  $service_file         = $couchpotato::params::cp_service_file,
  $service_name         = $couchpotato::params::cp_service_name,
  $sys_config_file      = $couchpotato::params::cp_sys_config_file,
  $settings_file        = $couchpotato::params::cp_settings_file,
  ) inherits couchpotato::params {
  class { 'couchpotato::install': }
  class { 'couchpotato::config': }
  class { 'couchpotato::service': }
}
