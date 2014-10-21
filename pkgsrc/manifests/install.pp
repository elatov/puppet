# == Class pkgsrc::install
#
class pkgsrc::install {

  $timestamp = generate('/usr/bin/date', '+%Y%d%m')
  
  ensure_resource ('file',
                   "${pkgsrc::user_home_dir}/apps",
                   {'ensure' => 'directory',
                    'owner'  => "${pkgsrc::settings['user']}",
                    'group'  => "${pkgsrc::settings['user']}"})
  
  if ($pkgsrc::settings['upgrade']){
    exec { "${module_name}-backup-old-pkgsrc":
      path    => ['bin','/usr/bin'],
      command => "mv ${pkgsrc::home} ${pkgsrc::home}_${timestamp}",
    }->
    file { $pkgsrc::home:
      ensure => 'directory',
    }
    
  }
  
}