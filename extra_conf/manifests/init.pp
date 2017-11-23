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
      case $::operatingsystem {
        'ubuntu': {
          sudo::conf { 'elatov':
            priority => 20,
            content  => "Defaults:elatov secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/opt/puppetlabs/bin",
          }
          file {"/etc/systemd/system/wpscan.service":
            ensure  => "present",
            source  => "puppet:///modules/extra_conf/wpscan.service",
            mode    => '0644',
          } ->
          file {"/etc/systemd/system/wpscan.timer":
            ensure  => "present",
            source  => "puppet:///modules/extra_conf/wpscan.timer",
            mode    => '0644',
          } ~>
          service { "wpscan.timer":
            ensure      => running,
            hasstatus   => true,
            hasrestart  => true,
            enable      => true,
            # require     => File["/etc/systemd/system/wpscan.timer"]
          }

          file {"/etc/systemd/system/docker-gc.service":
            ensure  => "present",
            source  => "puppet:///modules/extra_conf/docker-gc.service",
            mode    => '0644',
          } ->
          file {"/etc/systemd/system/docker-gc.timer":
            ensure  => "present",
            source  => "puppet:///modules/extra_conf/docker-gc.timer",
            mode    => '0644',
          } ~>
          service { "docker-gc.timer":
            ensure      => running,
            hasstatus   => true,
            hasrestart  => true,
            enable      => true,
          }
        }
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
