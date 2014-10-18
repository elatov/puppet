# == Class pkgsrc::install
#
class pkgsrc::install {

  $timestamp = generate('/usr/bin/date', '+%Y%d%m')
  
  file { '/root/apps':
    ensure  => 'directory',
  }
  
  if ($pkgsrc::settings['upgrade']){
    exec { "${module_name}-backup-old-pkgsrc":
      path    => ['bin','/usr/bin'],
      command => "mv ${pkgsrc::settings['home']} ${pkgsrc::settings['home']}_${timestamp}",
    }->
    file { $pkgsrc::settings['home']:
      ensure => 'directory',
    }
    
  }
  
}