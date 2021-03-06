class update_checker::params {
  
  $update_checker_user  = 'test'
  
  case $::osfamily {
    /(?i:Archlinux)/: {
        $update_checker_script      = 'pacman-check.bash'
        $update_checker_packages    = ['bash','cronie']
        $update_checker_cron_dir    = '/etc/cron.weekly'

    }
    /(?i:RedHat)/: { 
        $update_checker_script      = 'yumnotifier.sh'
        $update_checker_packages    = ['bash','cronie-anacron']
        $update_checker_cron_dir    = '/etc/cron.daily'

    }
    /(?i:Debian)/: { 
        $update_checker_script      = 'aptgetcheck.csh'
        $update_checker_packages    = ['csh','anacron']
        $update_checker_cron_dir    = '/etc/cron.daily'
    }
    /(?i:FreeBSD)/: { 
        $update_checker_script      = 'pkgng-check.bash'
        $update_checker_packages    = ['bash']
        $update_checker_cron_dir    = '/etc/periodic/daily'
    }
    /(?i:Solaris)/: { 
        $update_checker_script      = 'pkg-check.bash'
        $update_checker_packages    = ['bash']
    }
    default: {
        fail("The ${module_name} module is not supported on ${::osfamily}/${::operatingsystem}.")
    }
  }
}