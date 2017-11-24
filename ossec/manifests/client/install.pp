# == Class ossec::client::install
#
class ossec::client::install {

  case $::osfamily {
    'RedHat': {
		  ensure_packages ($ossec::client::package_name,
		                   { 'ensure'   => 'present' ,
		                     'require'  => Class['atomic']
		                   })
    }
    'Debian': {
      case $::operatingsystem {
        'debian': {
          if ($::operatingsystemmajrelease == '9') {
            apt::source { 'alienvault':
              location => "https://updates.atomicorp.com/channels/atomic/debian",
              release  => 'stretch',
              repos    => 'main',
              key      => {
                'id'      => '181866DF9DACA40E5B429B08FFBD5D0A4520AFA9',
                'source'  => "https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt"
              }
            }
          } else {
            apt::source { 'alienvault':
              location => "https://updates.atomicorp.com/channels/atomic/debian",
              release  => 'wheezy',
              repos    => 'main',
              key      => {
                'id'      => '181866DF9DACA40E5B429B08FFBD5D0A4520AFA9',
                'source'  => "hhttps://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt"
              }
            }
          }
        }
        'ubuntu': {
          apt::source { 'alienvault':
              location => "https://updates.atomicorp.com/channels/atomic/ubuntu",
              release  => 'xenial',
              repos    => 'main',
              key      => {
                'id'      => '181866DF9DACA40E5B429B08FFBD5D0A4520AFA9',
                'source'  => "https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt"
              }

            }
        }
      }
      ensure_packages($ossec::client::package_name,
          { ensure  => 'present',
            require => Apt::Source['alienvault'],
          })
    }
    'Solaris': {
			
			group { 'ossec':
			 ensure => present,
			}
			user { 'ossec':
				ensure      => 'present',
				shell       => '/bin/false',
				home        => $ossec::client::home_dir,
				allowdupe   => false,
				managehome  => true,
				require    => Group['ossec']
			}
			
      ensure_resource(file,'/usr/local',{ensure => 'directory'})
	    
	    file { $ossec::client::home_dir:
	      ensure  => 'directory',
	      require => File['/usr/local'],
	    }
	
      ensure_resource(file,'/usr/local/apps',{ensure => 'directory'})
      
	    file { $ossec::client::package_name:
	      ensure => 'present',
	      path   => "/usr/local/apps/${ossec::client::package_name}",
	      source => "puppet:///modules/ossec/${ossec::client::package_name}",
	      require => File['/usr/local/apps'],
	    }
	    
	    exec { "${module_name}-extract-ossec":
	      path    => ['/usr/bin','/usr/sbin'],
	      command => "tar xvf /usr/local/apps/${ossec::client::package_name} -C /usr/local",
	      creates => "${ossec::client::home_dir}/bin",
	      require => [File[$ossec::client::home_dir],File[$ossec::client::package_name]],
	    }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
