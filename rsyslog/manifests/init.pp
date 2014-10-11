# Class: my_rsyslog
#
# This module manages my_rsyslog
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class rsyslog (
  
  ### Package
  $package_name           = $rsyslog::params::rsyslog_package_name,
  
  ### Dir
  $rsyslog_d              = $rsyslog::params::rsyslog_d,
  
  ### Conf File
  $rc_conf                 = $rsyslog::params::rsyslog_rc_conf,
  $conf_file               = $rsyslog::params::rsyslog_conf_file,
  
  ### Service
  $service_name           = $rsyslog::params::rsyslog_service_name,
  
  ### Settings
  $remote_conf            = $rsyslog::params::rsyslog_remote_conf,
  $iptables_conf          = $rsyslog::params::rsyslog_iptables_conf,
  $override_settings      = undef,
  $default_settings       = $rsyslog::params::rsyslog_default_settings,
  
) inherits rsyslog::params {
  
  
  # check to see if override hash is a hash
  if !($override_settings == undef){
    validate_hash($override_settings)
  }
  # Merge settings with override-hash even if it's empty
  $settings = deep_merge($rsyslog::params::rsyslog_default_settings, $override_settings)
  
  class { 'rsyslog::install': }->
  class { 'rsyslog::config': }~>
  class { 'rsyslog::service': }->
  Class ['rsyslog']
}
