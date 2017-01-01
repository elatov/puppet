# == Class: extra_conf
#
# Full description of class extra_conf::server here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class extra_conf {
  class { 'sudo': 
   config_file_replace => false,
   purge               => false,
  }
  case $::osfamily {
    'Debian': {
			alternatives { 'editor':
			 path => '/usr/bin/vim.basic',
			}
			package {'apt-file':
        ensure => "present",
      }~>
      exec {'refresh-apt-file':
        command     => 'apt-file update',
        path        => ["/bin","/usr/bin"],
        provider    => "shell",
        refreshonly => true,
      }
      sudo::conf { 'admins':
        priority => 10,
        content  => "%adm ALL=(ALL) ALL",
      }
    }
    'RedHat': {
			augeas { "grub-conf-rhgb":
								context => "/files/etc/grub.conf",
								lens    => "grub.lns",
								incl    => "/etc/grub.conf",
								changes => "rm title/kernel/rhgb";
							}
     
     sudo::conf { 'admins':
        priority => 10,
        content  => "%wheel ALL=(ALL) ALL",
      }
      sudo::conf { 'elatov':
        priority => 20,
        content  => "Defaults:elatov secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/opt/puppetlabs/bin",
      }
    }
    'FreeBSD': {
      sudo::conf { 'admins':
        priority => 10,
        content  => "%wheel ALL=(ALL) ALL",
      }
     
    }
    'Solaris': {
     
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
