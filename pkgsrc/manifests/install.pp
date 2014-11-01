# == Class pkgsrc::install
#
class pkgsrc::install {

  $timestamp = generate('/usr/bin/date', '+%Y%d%m')
  
  ensure_resource ('file',
                   "/usr/local/apps",
                   {'ensure' => 'directory',})
  
  if ($pkgsrc::settings['upgrade']){
    exec { "${module_name}-backup-old-pkgsrc":
      path    => ['bin','/usr/bin'],
      command => "mv ${pkgsrc::home_dir} ${pkgsrc::home_dir}_${timestamp}",
    }->
    file { $pkgsrc::home_dir:
      ensure => 'directory',
    }
    
  }
  
}