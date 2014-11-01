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
    }
    'RedHat': {
     
    }
    'FreeBSD': {
     
    }
    'Solaris': {
     
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}