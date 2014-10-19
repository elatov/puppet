# == Class ossec::client::install
#
class ossec::client::install {

  case $::osfamily {
    'RedHat': {
		  ensure_resource ('yumrepo','atomic',{'ensure' => 'present'})
		  ensure_packages ($ossec::client::package_name,
		                   { 'ensure'   => 'present' ,
		                     'require'  => Class['atomic']
		                   })
    }
    'Debian': {
      apt::source { 'alienvault':
        location   => "http://ossec.alienvault.com/repos/apt/debian",
        release    => 'wheezy',
        repos      => 'main',
        key        => '9A1B1C65',
        key_source => 'http://ossec.alienvault.com/repos/apt/conf/ossec-key.gpg.key',
        include_src => false,
#        pin        => '510',
      }
            
      ensure_packages($ossec::client::package_name,
                      {ensure => 'present',
                       require  => Apt::Source['alienvault'],
                      })
    }
    'Solaris': {
      ensure_resource(file,'/usr/local',{ensure => 'directory'})
	    file { $ossec::client::home_dir:
	      ensure  => 'directory',
	      require => File['/usr/local'],
	    }
	
	    file { $ossec::client::package_name:
	      ensure => 'present',
	      path   => "/root/apps/${ossec::client::package_name}",
	      source => "puppet:///modules/ossec/${ossec::client::package_name}",
	    }
	    
	    exec { "${module_name}-extract-ossec":
	      path    => ['/usr/bin','/usr/sbin'],
	      command => "tar xvf /root/apps/${ossec::client::package_name} -C /usr/local",
	      creates => "${ossec::client::home_dir}/bin",
	      require => [File[$ossec::client::home_dir],File[$ossec::client::package_name]],
	    }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
