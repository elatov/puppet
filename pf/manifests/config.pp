# == Class pf::config
#
# This class is called from pf
#
class pf::config {

  $settings_keys = keys($pf::settings)
  
  settings {$settings_keys:
    config_file => "${pf::config_dir}/${pf::rc_conf_file}",
    settings_hash => $pf::settings,
  }
      
  file { $pf::home:
    ensure  => 'directory',
  }
  
  file { $pf::config_file:
    ensure  => 'present',
    path    => "${pf::home}/${pf::config_file}",
    source => "puppet://modules/pf/${pf::config_file}",
#    source => "/tmp/vagrant-puppet-3/modules-0/pf/files/${pf::config_file}",
    require => File [$pf::home],
  }
}
