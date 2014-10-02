class zabbix::server (
  ## Packages
  $package_name           = $zabbix::params::server_zabbix_package_name,
  $web_package_name       = $zabbix::params::server_zabbix_web_package_name,
  
  ## Services
  $service_name           = $zabbix::params::server_zabbix_service_name,
  
  ## Dirs
  $config_dir             = $zabbix::params::server_zabbix_config_dir,
  
  ## Conf Files
  $config_file            = $zabbix::params::server_zabbix_config_file,
  
  ## settings
  $override_settings      = undef,
  $default_settings       = $zabbix::params::server_zabbix_default_settings,
  $version                = $zabbix::params::server_zabbix_version,
  $enable_partition_mysql = $zabbix::params::server_zabbix_enable_partition_mysql,
  $enable_web             = $zabbix::params::server_zabbix_enable_partition_mysql,
    
) inherits zabbix::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if passed in override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($zabbix::params::server_zabbix_default_settings, $override_settings)
  
  class { 'zabbix::server::install': } ->
  class { 'zabbix::server::config': } ~>
  class { 'zabbix::server::service': } ->
  Class['zabbix::server']
}

