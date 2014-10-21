# == Class grive::config
#
# This class is called from grive
#
class grive::config {

  # create .gdrive dir
  file{"${grive::user_home_dir}/.gdrive":
    ensure  => 'directory',
    owner   => $grive::settings['user'],
    group   => $grive::settings['user'],
  }
 
  if $grive::initial_setup {
   notify {"go run grive -a in ${grive::user_home_dir}/.gdrive":}
  } else {
    ensure_resource ('file','/usr/local/bin',{'ensure' => 'directory',})
    
    file { '/usr/local/bin/grive':
      ensure => 'link',
      target => "${grive::settings['home_dir']}/grive/bin/grive",
    }
    
    file { "${grive::user_home_dir}/.gdrive/notes/backup/bin/rsync_backup.bash":
      mode => '0755',
    }->
    file { '/usr/local/backup':
      ensure  => 'link',
      target  => "${grive::user_home_dir}/.gdrive/notes/backup",
    }-> 
     file { '/usr/local/bin/rsync_backup':
      ensure  => 'link',
      target  => "${grive::user_home_dir}/.gdrive/notes/backup/bin/rsync_backup.bash",
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
      zfs:{
        cron {"backup":
          command => "/usr/local/bin/rsync_backup",
          user => "root",
          minute => "30",
          hour   => "03",
          monthday => ["10","24"],
        }
      }
    }
    
		file { "${grive::user_home_dir}/.bashrc":
			ensure => 'link',
			target => "${grive::user_home_dir}/.gdrive/notes/.bashrc",
		}
		file { "${grive::user_home_dir}/.bash_profile":
      ensure => 'link',
      target => "${grive::user_home_dir}/.gdrive/notes/.bash_profile",
    }
    
    file { "${grive::user_home_dir}/.bash_aliases":
      ensure => 'link',
      target => "${grive::user_home_dir}/.gdrive/notes/.bash_aliases",
    }
    
    file { "${grive::user_home_dir}/.vimrc":
      ensure => 'link',
      target => "${grive::user_home_dir}/.gdrive/notes/.vimrc",
    }
    
    file { "${grive::user_home_dir}/.inputrc":
      ensure => 'link',
      target => "${grive::user_home_dir}/.gdrive/notes/.inputrc",
    }
    
    file { "${grive::user_home_dir}/.screenrc":
      ensure => 'link',
      target => "${grive::user_home_dir}/.gdrive/notes/.screenrc",
    }
    
    file { "${grive::user_home_dir}/.tricks":
      ensure => 'link',
      target => "${grive::user_home_dir}/.gdrive/notes/.tricks",
    }
    
    file {"${grive::user_home_dir}/.ssh":
      ensure => 'directory',
      mode   => '0700',
      owner  => $grive::settings['user'],
      group  => $grive::settings['user'],
    }
    file { "${grive::user_home_dir}/.ssh/config":
      ensure  => 'link',
      target  => "${grive::user_home_dir}/.gdrive/notes/.ssh/config",
      require => File["${grive::user_home_dir}/.ssh"],
    }
    
    file { "${grive::user_home_dir}/.gdrive/notes/scripts/bash/vigsync.bash":
      mode => '0755',
    }->
    file { '/usr/local/bin/vigsync':
      ensure  => 'link',
      target  => "${grive::user_home_dir}/.gdrive/notes/scripts/bash/vigsync.bash",
    }
    
    file { "${grive::user_home_dir}/.gdrive/notes/scripts/python/ps_mem.py":
      mode => '0755',
    }->
    file { '/usr/local/bin/ps_mem.py':
      ensure  => 'link',
      target  => "${grive::user_home_dir}/.gdrive/notes/scripts/python/ps_mem.py",
    }
    
    case $::osfamily {
	    /(?i:RedHat)/: { 
	        file {"${grive::user_home_dir}/.gdrive/notes/scripts/sh/yumnotifier.sh":
            ensure => 'present',
            mode   => '0755',
          }
	    }
	    /(?i:Debian)/: { 
	       file {"${grive::user_home_dir}/.gdrive/notes/scripts/csh/aptgetcheck.csh":
            ensure => 'present',
            mode   => '0755',
          }
	    }
	    /(?i:FreeBSD)/: { 
         file {"${grive::user_home_dir}/.gdrive/notes/scripts/bash/pkgng-check.bash":
            ensure => 'present',
            mode   => '0755',
          }
      }
      /(?i:Solaris)/: { 
         file {"${grive::user_home_dir}/.gdrive/notes/scripts/bash/pkgin-check.bash":
            ensure => 'present',
            mode   => '0755',
          }
          
          file {"${grive::user_home_dir}/.gdrive/notes/scripts/bash/pkg-check.bash":
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
