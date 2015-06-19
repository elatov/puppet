# == Class drive::config
#
# This class is called from drive
#
class drive::config {

  # create .gdrive dir
  file{"${drive::user_home_dir}/.gdrive":
    ensure  => 'directory',
    owner   => $drive::settings['user'],
    group   => $drive::settings['user'],
  }
 
  if $drive::initial_setup {
   notify {"go run drive auth in ${drive::user_home_dir}/.gdrive":}
  } else {
    ensure_resource ('file','/usr/local/bi',{'ensure' => 'directory',})
    
    file { '/usr/local/bin/drive':
      ensure => 'link',
      target => "${drive::settings['home_dir']}/drive/bin/drive",
    }
    
    file { "${drive::user_home_dir}/.gdrive/notes/backup/bin/rsync_backup.bash":
      mode => '0755',
    }->
    file { '/usr/local/backup':
      ensure  => 'link',
      target  => "${drive::user_home_dir}/.gdrive/notes/backup",
    }-> 
     file { '/usr/local/bin/rsync_backup':
      ensure  => 'link',
      target  => "${drive::user_home_dir}/.gdrive/notes/backup/bin/rsync_backup.bash",
    }
    case $drive::settings['host'] {
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
      zfs:{
        cron {"backup":
          command => "/usr/local/bin/rsync_backup",
          user => "root",
          minute => "30",
          hour   => "03",
          monthday => ["10","24"],
        }
      }
      puppet:{
        cron {"backup":
          command => "/usr/local/bin/rsync_backup",
          user => "root",
          minute => "30",
          hour   => "05",
          monthday => ["8","22"],
        }
      }
    }
    
		file { "${drive::user_home_dir}/.bashrc":
			ensure => 'link',
			target => "${drive::user_home_dir}/.gdrive/notes/.bashrc",
		}
		file { "${drive::user_home_dir}/.bash_profile":
      ensure => 'link',
      target => "${drive::user_home_dir}/.gdrive/notes/.bash_profile",
    }
    
    file { "${drive::user_home_dir}/.bash_aliases":
      ensure => 'link',
      target => "${drive::user_home_dir}/.gdrive/notes/.bash_aliases",
    }
    
    file { "${drive::user_home_dir}/.vimrc":
      ensure => 'link',
      target => "${drive::user_home_dir}/.gdrive/notes/.vimrc",
    }
    
    file { "${drive::user_home_dir}/.inputrc":
      ensure => 'link',
      target => "${drive::user_home_dir}/.gdrive/notes/.inputrc",
    }
    
    file { "${drive::user_home_dir}/.screenrc":
      ensure => 'link',
      target => "${drive::user_home_dir}/.gdrive/notes/.screenrc",
    }
    
    file { "${drive::user_home_dir}/.tricks":
      ensure => 'link',
      target => "${drive::user_home_dir}/.gdrive/notes/.tricks",
    }
    
    file {"${drive::user_home_dir}/.ssh":
      ensure => 'directory',
      mode   => '0700',
      owner  => $drive::settings['user'],
      group  => $drive::settings['user'],
    }
    file { "${drive::user_home_dir}/.ssh/config":
      ensure  => 'link',
      target  => "${drive::user_home_dir}/.gdrive/notes/.ssh/config",
      require => File["${drive::user_home_dir}/.ssh"],
    }
    
    file { "${drive::user_home_dir}/.gdrive/notes/scripts/bash/vigsync.bash":
      mode => '0755',
    }->
    file { '/usr/local/bin/vigsync':
      ensure  => 'link',
      target  => "${drive::user_home_dir}/.gdrive/notes/scripts/bash/vigsync.bash",
    }
    
    file { "${drive::user_home_dir}/.gdrive/notes/scripts/python/ps_mem.py":
      mode => '0755',
    }->
    file { '/usr/local/bin/ps_mem.py':
      ensure  => 'link',
      target  => "${drive::user_home_dir}/.gdrive/notes/scripts/python/ps_mem.py",
    }
    
    case $::osfamily {
	    /(?i:RedHat)/: { 
	        file {"${drive::user_home_dir}/.gdrive/notes/scripts/sh/yumnotifier.sh":
            ensure => 'present',
            mode   => '0755',
          }
	    }
	    /(?i:Debian)/: { 
	       file {"${drive::user_home_dir}/.gdrive/notes/scripts/csh/aptgetcheck.csh":
            ensure => 'present',
            mode   => '0755',
          }
	    }
	    /(?i:FreeBSD)/: { 
         file {"${drive::user_home_dir}/.gdrive/notes/scripts/bash/pkgng-check.bash":
            ensure => 'present',
            mode   => '0755',
          }
      }
      /(?i:Solaris)/: { 
         file {"${drive::user_home_dir}/.gdrive/notes/scripts/bash/pkgin-check.bash":
            ensure => 'present',
            mode   => '0755',
          }
          
          file {"${drive::user_home_dir}/.gdrive/notes/scripts/bash/pkg-check.bash":
            ensure => 'present',
            mode   => '0755',
          }
      }
	    default: {
	        fail("The ${module_name} module is not supported on ${::osfamily}/${::operatingsystem}.")
	    }
    }
    
  }
}