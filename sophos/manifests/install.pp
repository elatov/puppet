# == Class sophos::install
#
# This class is called from sophos for install.
#
class sophos::install {

  $package_name = "sav-linux-free-${::sophos::version}.tgz"
	ensure_resource (  'file',
	                   '/usr/local/apps/sophos',
	                   {'ensure' => 'directory',}
	                 )
	
	# let's get the TAR archive from the puppet master
  file {"get-${package_name}":
    ensure => 'present',
    path   => "/usr/local/apps/sophos/${sophos::package_name}",
    source => "puppet:///modules/sophos/${sophos::package_name}",
    require => File['/usr/local/apps/sophos'], 
  }
  
  # extract the TAR
  if $sophos::initial_setup {
    ensure_packages("${sophos::package_preq}",{ 'ensure' => 'present' })
    
	  exec {"extract-$package_name":
	    command     => "tar xzf /usr/local/apps/sophos/${package_name} -C ${sophos::setup_dir}",
	    provider    => "shell",
	#    creates     => "${drive::settings['home_dir']}/drive/bin/drive",
	    subscribe   => File["get-${package_name}"],
	    refreshonly => true,
	  }
	  notify {"go run ./install.sh in ${sophos::setup_dir}/sophos-av":}
  }
}
