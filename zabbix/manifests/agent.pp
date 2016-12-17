class zabbix::agent (
  ## Packages
  $package_name           = $zabbix::params::agent_zabbix_package_name,
  
  ## Services
  $service_name           = $zabbix::params::agent_zabbix_service_name,
  
  ## Dirs
  $config_dir             = $zabbix::params::agent_zabbix_config_dir,
  $custom_scripts_dir     = $zabbix::params::agent_zabbix_custom_scripts_dir,
  $custom_conf_dir        = $zabbix::params::agent_zabbix_custom_conf_dir,
  $manifest_dir           = $zabbix::params::agent_zabbix_manifest_dir,
  $service_dir            = $zabbix::params::agent_zabbix_service_dir,
  $home_dir               = $zabbix::params::agent_zabbix_home_dir,
  
  ## Conf Files
  $config_file            = $zabbix::params::agent_zabbix_config_file,
  $manifest_file          = $zabbix::params::agent_zabbix_manifest_file,
  $service_file           = $zabbix::params::agent_zabbix_service_file,
  
  ## settings
  $override_settings      = undef,
  $default_settings       = $zabbix::params::agent_zabbix_default_settings,
#  $version                = $zabbix::params::agent_zabbix_version,
) inherits zabbix::params {

  # validate parameters here
  validate_hash($default_settings)
  validate_string($package_name)
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($default_settings, $override_settings)
#  notify {"end hash looks like this ${settings}":}
  if ($::osfamily == 'FreeBSD'){
    $freebsd_package_name           = "zabbix${settings['version']}-agent"
    $freebsd_config_dir             = "/usr/local/etc/zabbix${settings['version']}"
    $freebsd_custom_conf_dir        = "${freebsd_config_dir}/zabbix_agentd.conf.d"
    $freebsd_custom_scripts_dir     = "${freebsd_config_dir}/custom-scripts.d"
  }
  
  if ($::osfamily == 'Solaris'){
    $solaris_package_name           = "zabbix_agents_${settings['version']}.0.solaris10.amd64.tar.gz"
#    $freebsd_config_dir             = "/usr/local/etc/zabbix${settings['version']}"
#    $freebsd_custom_conf_dir        = "${freebsd_config_dir}/zabbix_agentd.conf.d"
#    $freebsd_custom_scripts_dir     = "${freebsd_config_dir}/custom-scripts.d"
  }
  
  class { 'zabbix::agent::install': } ->
  class { 'zabbix::agent::config': } ~>
  class { 'zabbix::agent::service': } ->
  Class['zabbix::agent']
}
