# == Class plexms::config::settings
#
# This class is called from plexms::config
#
define plexms::settings (
    $key          = $title,
    $settings,     
    $config_file,
) {
  
  $value = $settings[$key]
  
  augeas{"plexms_setting_${key}":
       incl    => "${config_file}", 
       lens    => 'Systemd.lns',
       context => "/files${config_file}",
       changes => "set Service/${key}/value ${value}",
       onlyif  => "match Service/${key}/value not_include ${value}",
     }
}
