class users {
	group { "elatov":
		ensure => present,
		gid    => 1000
	}
  case $::osfamily {
    'Debian': {
      @user { "elatov":
        ensure      => present,
        uid         => "1000",
        gid         => "1000",
        groups      => ["adm"],
        membership  => minimum,
        shell       => "/bin/bash",
        allowdupe   => false,
        managehome  => true,
        require    => Group["elatov"]
      }
    }
    'RedHat': {
			@user { "elatov":
				ensure      => present,
				uid         => "1000",
				gid         => "1000",
				groups      => ["wheel"],
				membership  => minimum,
				shell       => "/bin/bash",
				allowdupe   => false,
				managehome  => true,
				require     => Group["elatov"]
			}
    }
    'FreeBSD': {
      ensure_packages('bash',{ensure => 'present'})
      
      file {'/bin/bash':
        ensure => link,
        target => '/usr/local/bin/bash',
        require => Package['bash'],
      }
      
      @user { "elatov":
        ensure      => present,
        uid         => "1000",
        gid         => "1000",
        groups      => ["wheel"],
        membership  => minimum,
        shell       => "/bin/bash",
        allowdupe   => false,
        managehome  => true,
        require     => [Group["elatov"],Package['bash'],File['/bin/bash']]
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
	
	
	User <| title == "elatov" |>
}
