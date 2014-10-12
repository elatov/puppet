class update_checker::params {
  $update_checker_user  = 'test'
  case $::osfamily {
    /(?i:RedHat)/: { 
        $update_checker_script      = 'yumnotifier.sh'
        $update_checker_packages    = ['bash','cronie-anacron']
        $update_checker_target_dir  = "/home/${update_checker::user}/.gdrive/notes/scripts/sh"
        $update_checker_cron_dir    = '/etc/cron.daily'

    }
    /(?i:Debian)/: { 
        $update_checker_script      = 'aptgetcheck.csh'
        $update_checker_packages    = ['csh','anacron']
        $update_checker_target_dir  = "/home/${update_checker::user}/.gdrive/notes/scripts/csh"
        $update_checker_cron_dir    = '/etc/cron.daily'
    }
    /(?i:FreeBSD)/: { 
        $update_checker_script      = 'pkgng-check.bash'
        $update_checker_packages    = ['bash']
        $update_checker_target_dir  = "/home/${update_checker::user}/.gdrive/notes/scripts/bash"
        $update_checker_cron_dir    = '/etc/periodic/daily'
    }
    default: {
        fail("The ${module_name} module is not supported on ${::osfamily}/${::operatingsystem}.")
    }
  }
}