# == Class exim::server::settings
#
# This class is called from exim::server:config
#
define exim::client::settings (
    $key               = $title,
    $settings_hash,
    $config_file,
) {

  $value = $settings_hash[$key]

	augeas{"exim_${config_file}_setting_${key}":
		incl    => "${config_file}",
		lens    => 'Shellvars.lns',
		context => "/files${config_file}",
		changes => "set ${key} '\"${value}\"'",
		onlyif  => "match ${key} not_include ${value}",
	}
}
