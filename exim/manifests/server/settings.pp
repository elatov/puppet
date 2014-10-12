# == Class exim::server::settings
#
# This class is called from exim::server:config
#
define exim::server::settings (
    $key               = $title,
    $settings_hash     = $exim::server::settings,
    $config_file       = $exim::server::config_file,
) {

  $value = $settings_hash[$key]

  augeas{"exim_server_setting_${key}":
       incl    => "${config_file}",
       lens    => 'Shellvars.lns',
       context => "/files${config_file}",
       changes => "set ${key} '${value}'",
       onlyif  => "match ${key} not_include ${value}",
     }
}
