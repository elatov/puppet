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
      if ($::operatingsystemmajrelease == '8') {
				apt::source { 'alienvault':
					location   => "http://ossec.wazuh.com/repos/apt/debian",
					release    => 'jessie',
					repos      => 'main',
#					key        => '9A1B1C65',
#					key_source => 'http://ossec.alienvault.com/repos/apt/conf/ossec-key.gpg.key',
					include_src => false,
					#        pin        => '510',
				} 
			} else {
				apt::source { 'alienvault':
					location   => "http://ossec.wazuh.com/repos/apt/debian",
					release    => 'wheezy',
					repos      => 'main',
#					key        => '9A1B1C65',
#					key_source => 'http://ossec.alienvault.com/repos/apt/conf/ossec-key.gpg.key',
					include_src => false,
					#        pin        => '510',
				}       
      }
            
      ensure_packages($ossec::client::package_name,
                      {ensure => 'present',
                       require  => Apt::Source['alienvault'],
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
