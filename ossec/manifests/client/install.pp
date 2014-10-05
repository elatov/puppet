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
      
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
