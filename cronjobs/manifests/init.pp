# Class: cronjobs
#
# This module manages cronjobs
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cronjobs {
  
  case $::osfamily {
    'Debian': {
      cron {"ntp":
        command     => '/usr/sbin/ntpdate -s ntp.ubuntu.com',
        user        => 'root',
        minute      => '01',
      }
    }
    'RedHat': {
			cron {"ntp":
				command   => '/usr/sbin/ntpdate -s 0.north-america.pool.ntp.org',
				user      => 'root',
				minute    => '05',
			}
    }
    'FreeBSD': {
      ensure_packages ("ntpdate", {ensure => "present"})
      
      cron {"freebsd-update":
        command => '/usr/sbin/freebsd-update cron',
        user    => 'root',
        minute  => '00',
        hour    => '03'
      }
      cron {"ntp":
        command   => '/usr/sbin/ntpdate -4 -s 0.north-america.pool.ntp.org',
        user      => 'root',
        minute    => '02',
      }

    }
    'Solaris': {
      ensure_packages ("ntp", {ensure => "present"})
      
      cron {"ntp":
        command   => '/usr/sbin/ntpdate -s 0.north-america.pool.ntp.org',
        user      => 'root',
        minute    => '35',
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  

}
