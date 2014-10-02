class zabbix::agent (
  ## Packages
  $package_name           = $zabbix::params::agent_zabbix_package_name,
  
  ## Services
  $service_name           = $zabbix::params::agent_zabbix_service_name,
  
  ## Dirs
  $config_dir             = $zabbix::params::agent_zabbix_config_dir,
  $custom_scripts_dir     = $zabbix::params::agent_zabbix_custom_scripts_dir,
  $agentd_conf_dir        = $zabbix::params::agent_zabbix_agentd_conf_dir,
  
  ## Conf Files
  $config_file            = $zabbix::params::agent_zabbix_config_file,
  
  ## settings
  $override_settings      = undef,
  $default_settings       = $zabbix::params::agent_zabbix_default_settings,
  $version                = $zabbix::params::agent_zabbix_version,
) inherits zabbix::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($zabbix::params::server_zabbix_default_settings, $override_settings)
  
  class { 'zabbix::agent::install': } ->
  class { 'zabbix::agent::config': } ~>
  class { 'zabbix::agent::service': } ->
  Class['zabbix::agent']
}
