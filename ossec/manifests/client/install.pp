# == Class ossec::client::install
#
class ossec::client::install inherits ossec::params {

  case $::osfamily {
    'RedHat': {
		  ensure_resource ('yumrepo','atomic',{'ensure' => 'present'})
		  ensure_packages ($ossec_client_package_name,
		                   { 'ensure'   => 'latest' ,
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
#        pin        => '510',
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
