class zabbix::server (
  ## Packages
  $package_name           = $zabbix::params::server_zabbix_package_name,
  
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
    
) inherits zabbix::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # Merge settings if override-hash is passed in
#  if $override_settings == undef {
    $settings = deep_merge($zabbix::params::server_zabbix_default_settings, $override_settings)
#  }
  
  class { 'zabbix::server::install': } ->
  class { 'zabbix::server::config': } ~>
#  class { 'zabbix::server::service': } ->
  Class['zabbix::server']
}

