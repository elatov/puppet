define pf::settings (
      $key = $title,
      $config_file = '/etc/rc.conf',
      $settings_hash = {a1 => 1, a2 => 2},
) {

  validate_hash($settings_hash)
  $value = $settings_hash[$key]
  
  file_line { "${key}_in_${config_file}":
    path => $config_file,
    line => "${key}=\"${value}\"",
  }
}
