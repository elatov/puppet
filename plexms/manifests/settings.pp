# == Class plexms::config::settings
#
# This class is called from plexms::config
#
define plexms::settings (
    $key          = $title,
    $settings     = $plexms::params::plexms_settings,
    $config_file  = $plexms::params::plexms_config_file,
) {
  
  $value = $plexms::params::plexms_settings[$key]
  
  augeas{"plexms_setting_${key}":
       incl    => "${config_file}", 
       lens    => 'Puppet.lns',
       context => "/files${config_file}",
       changes => "set */${key} ${value}",
       onlyif  => "match */${key} not_include ${value}",
     }
}