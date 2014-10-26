# == Class subsonic::install
#
class subsonic::install {

  if ($subsonic::settings['pkgs_pre'] != undef){
    ensure_resource(package,$subsonic::settings['pkgs_pre'],{ensure => 'present'})
  }
  
  case $::osfamily {
    'Redhat': {
      
      ensure_resource('file','/usr/local/apps',{ensure => 'directory'})
      
      # let's get the RPM from the puppet master
      file {"get-${subsonic::package_name}":
        ensure => 'present',
        path   => "/usr/local/apps/${subsonic::package_name}",
        source => "puppet:///modules/subsonic/${subsonic::package_name}",
        require => File ['/usr/local/apps'],
      }
      
      # now install the rpm, also inhibiting the postinstall run scripts, since it automatically starts the service
      package { 'subsonic':
        provider => 'rpm',
        source   => "/usr/local/apps/${subsonic::package_name}",
        require  => [File ["get-${subsonic::package_name}"],Package[$subsonic::settings['pkgs_pre']]],
        install_options => '--noscripts',
      }->
      # change ownership of /var/subsonic dir
      file{ $subsonic::home_dir:
        ensure => 'directory',
        owner  => $subsonic::settings['conf']['user'],
        group  => $subsonic::settings['conf']['user'],
      }->
      file {"/usr/bin/subsonic":
        ensure => 'link',
        target  => "${subsonic::install_dir}/subsonic.sh",
      }
    }
    'Debian': {
			apt::source { 'getdeb':
				location    => 'http://archive.getdeb.net/ubuntu/',
				release     => "${::lsbdistcodename}-getdeb",
				repos       => 'apps',
				key         => '46D7E7CF',
				key_source  => 'http://archive.getdeb.net/getdeb-archive.key',
			}
					
			package { $subsonic::package_name:
				ensure  => present,
				require => [Package[$subsonic::settings['pkgs_pre']],Apt::Source['getdeb']],
			}
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }
  
	if ($subsonic::settings['enable_muscab'] != undef){
    # get the zip from puppet master
		file { $subsonic::musiccabinet_zip:
		  ensure => 'present',
		  path   => "/usr/local/apps/${subsonic::musiccabinet_zip}",
		  source => "puppet:///modules/subsonic/${subsonic::musiccabinet_zip}",
		  require => File ['/usr/local/apps'],
		}
		
		# now extract the zip
		exec { "${module_name}-install-musiccabinet":
		  provider  => 'shell',
		  cwd       => "/usr/local/apps",
		  command   => "unzip -jo ${subsonic::musiccabinet_zip} subsonic-installer-standalone/subsonic* -d ${subsonic::install_dir}",
		  require   => [File [$subsonic::musiccabinet_zip],
		                Package[$subsonic::settings['pkgs_pre']],
		                Package ['subsonic']],
		  creates   => "${subsonic::install_dir}/subsonic.bat",
		}
    
    file{ "${subsonic::install_dir}/subsonic.sh":
      ensure  => 'present',
      mode    => '0755',
      require => Exec["${module_name}-install-musiccabinet"],
    }
		
		class { 'postgresql::server':
		  ip_mask_allow_all_users    => '0.0.0.0/0',
			listen_addresses           => '127.0.0.1',
			ipv4acls                   => ['host all all 127.0.0.1/32 md5','local all all md5'],
			postgres_password          => $subsonic::settings['pgsql_pass'],
			
		}
		
		class { 'postgresql::server::contrib':
		  package_name       => 'postgresql-contrib', 
    }
	}
}
