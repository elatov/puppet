class zabbix::server (
  ## Packages
  $package_name         = $zabbix::params::server_zabbix_package_name,
  
  ## Services
  $service_name         = $zabbix::params::server_zabbix_service_name,
  
  ## Dirs
  $config_dir           = $zabbix::params::server_zabbix_config_dir,
  
  ## Conf Files
  $config_file          = $zabbix::params::server_zabbix_config_file,
  
  ## settings
  $override_settings    = $zabbix::params::server_zabbix_settings,
  $version              = $zabbix::params::server_zabbix_settings,
    
) inherits zabbix::params {

  $settings = deep_merge($zabbix::params::server_zabbix_default_settings, $override_settings)
  
  # validate parameters here
  validate_hash($settings)
  validate_string($package_name)

  class { 'zabbix::server::install': } ->
  class { 'zabbix::server::config': } ~>
  class { 'zabbix::server::service': } ->
  Class['zabbix::server']
}

