# == Class grive::config
#
# This class is called from grive
#
class grive::config {

  ensure_resource ('user',$grive::settings['user'],{ 'ensure'=> 'present' })
    
  # create .gdrive dir
  file{"/home/${grive::settings['user']}/.gdrive":
    ensure  => 'directory',
    owner   => $grive::settings['user'],
    group   => $grive::settings['user'],
  }
 
  if $grive::initial_setup {
   notify {"go run grive -a in /home/${grive::settings['user']}/.gdrive":}
  } else {
    file { '/usr/local/bin/grive':
      ensure => 'link',
      target => "${grive::settings['home_dir']}grive/bin/grive",
    }
    
    file { "/home/${grive::settings['user']}/.gdrive/notes/backup/bin/rsync_backup.bash":
      mode => '0755',
    }->
    file { '/usr/local/backup':
      ensure  => 'link',
      target  => "/home/${grive::settings['user']}/.gdrive/notes/backup",
    }-> 
     file { '/usr/local/bin/rsync_backup':
      ensure  => 'link',
      target  => "/home/${grive::settings['user']}/.gdrive/notes/backup/bin/rsync_backup.bash",
    }
    case $grive::settings['host'] {
      m2:{
				cron {"backup":
					command => "/usr/local/bin/rsync_backup",
					user => "root",
					minute => "00",
					hour   => "01",
          monthday => ["14","28"],
				}
      }
      kerch:{
        cron {"backup":
          command => "/usr/local/bin/rsync_backup",
          user => "root",
          minute => "30",
          hour   => "02",
          monthday => ["13","27"],
        }
      }
      moxz:{
        cron {"backup":
          command => "/usr/local/bin/rsync_backup",
          user => "root",
          minute => "00",
          hour   => "02",
          monthday => ["12","26"],
        }
      }
    }
    
		file { "/home/${grive::settings['user']}/.bashrc":
			ensure => 'link',
			target => "/home/${grive::settings['user']}/.gdrive/notes/.bashrc",
		}
		file { "/home/${grive::settings['user']}/.bash_profile":
      ensure => 'link',
      target => "/home/${grive::settings['user']}/.gdrive/notes/.bash_profile",
    }
    
    file { "/home/${grive::settings['user']}/.bash_aliases":
      ensure => 'link',
      target => "/home/${grive::settings['user']}/.gdrive/notes/.bash_aliases",
    }
    
    file { "/home/${grive::settings['user']}/.vimrc":
      ensure => 'link',
      target => "/home/${grive::settings['user']}/.gdrive/notes/.vimrc",
    }
    
    file { "/home/${grive::settings['user']}/.inputrc":
      ensure => 'link',
      target => "/home/${grive::settings['user']}/.gdrive/notes/.inputrc",
    }
    
    file { "/home/${grive::settings['user']}/.screenrc":
      ensure => 'link',
      target => "/home/${grive::settings['user']}/.gdrive/notes/.screenrc",
    }
    
    file { "/home/${grive::settings['user']}/.tricks":
      ensure => 'link',
      target => "/home/${grive::settings['user']}/.gdrive/notes/.tricks",
    }
    
    file {"/home/${grive::settings['user']}/.ssh":
      ensure => 'directory',
      mode   => '0700',
      owner  => $grive::settings['user'],
      group  => $grive::settings['user'],
    }
    file { "/home/${grive::settings['user']}/.ssh/config":
      ensure  => 'link',
      target  => "/home/${grive::settings['user']}/.gdrive/notes/.ssh/config",
      require => File["/home/${grive::settings['user']}/.ssh"],
    }
    
    file { "/home/${grive::settings['user']}/.gdrive/notes/scripts/bash/vigsync.bash":
      mode => '0755',
    }->
    file { '/usr/local/bin/vigsync':
      ensure  => 'link',
      target  => "/home/${grive::settings['user']}/.gdrive/notes/scripts/bash/vigsync.bash",
    }
    
    file { "/home/${grive::settings['user']}/.gdrive/notes/scripts/python/ps_mem.py":
      mode => '0755',
    }->
    file { '/usr/local/bin/ps_mem.py':
      ensure  => 'link',
      target  => "/home/${grive::settings['user']}/.gdrive/notes/scripts/python/ps_mem.py",
    }
    
    case $::osfamily {
	    /(?i:RedHat)/: { 
	        file {"/home/${grive::settings['user']}/.gdrive/notes/scripts/sh/yumnotifier.sh":
            ensure => 'present',
            mode   => '0755',
          }
	    }
	    /(?i:Debian)/: { 
	       file {"/home/${grive::settings['user']}/.gdrive/notes/scripts/csh/aptgetcheck.csh":
            ensure => 'present',
            mode   => '0755',
          }
	    }
#	    /(?i:FreeBSD)/: { 
#         file {"/home/${grive::settings['user']}/.gdrive/notes/scripts/sh/pkgngcheck.sh":
#            ensure => 'present',
#            mode   => '0755',
#          }
#      }
	    default: {
	        fail("The ${module_name} module is not supported on ${::osfamily}/${::operatingsystem}.")
	    }
    }
    
  }
}
