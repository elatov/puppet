# == Class: mysudo
#
# Full description of class mysudo here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class mysudo {

	class { 'sudo': 
	 config_file_replace => false,
	 purge               => false,
	}
  	
  case $::osfamily {
    'Debian': {
      sudo::conf { 'admins':
        priority => 10,
        content  => "%adm ALL=(ALL) ALL",
      }
    }
    'RedHat': {
			sudo::conf { 'admins':
				priority => 10,
				content  => "%wheel ALL=(ALL) ALL",
			}
			sudo::conf { 'elatov':
				priority => 20,
				content  => "Defaults:elatov secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin",
			}
    }
    'FreeBSD': {
      sudo::conf { 'admins':
        priority => 10,
        content  => "%wheel ALL=(ALL) ALL",
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
