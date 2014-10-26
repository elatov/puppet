# == Class subsonic::install
#
class subsonic::install inherits subsonic {

ensure_resource(package,$java_jdk_package_name,{ensure => 'latest'})

  case $::osfamily {
    'Redhat': {
      
      file { "/home/${subsonic_settings['user']}/apps":
        ensure => 'directory',
        owner  => $subsonic_settings['user'],
        group  => $subsonic_settings['user'],
      }
      
      # let's get the RPM from the puppet master
      file {"get-${subsonic_rpm}":
        ensure => 'present',
        path   => "/home/${subsonic_settings['user']}/apps/${subsonic_rpm}",
        source => "puppet:///modules/subsonic/${subsonic_rpm}",
        require => File ["/home/${subsonic_settings['user']}/apps"],
      }
      
      # now install the rpm, also inhibiting the postinstall run scripts, since it automatically starts the service
      package {$subsonic_package_name:
        provider => 'rpm',
        source   => "/home/${subsonic_settings['user']}/apps/${subsonic_rpm}",
        require  => [File ["get-${subsonic_rpm}"],Package[$java_jdk_package_name]],
        install_options => '--noscripts',
      }->
      # change ownership of /var/subsonic dir
      file{$subsonic_home:
        ensure => 'directory',
        owner  => $subsonic_settings['user'],
        group  => $subsonic_settings['user'],
      }->
      file {"/usr/bin/subsonic":
        ensure => 'link',
        target  => "${subsonic_install_dir}/subsonic.sh",
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
					
			package { $subsonic_package_name:
				ensure  => present,
				require => [Package[$java_jdk_package_name],Apt::Source['getdeb']],
			}
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }
  
	if ($enable_musiccabinet){
    # get the zip from puppet master
		file {$musiccabinet_zip:
		  ensure => 'present',
		  path   => "/home/${subsonic_settings['user']}/apps/${musiccabinet_zip}",
		  source => "puppet:///modules/subsonic/${musiccabinet_zip}",
		  require => File ["/home/${subsonic_settings['user']}/apps"],
		}
		
		# ensure the unzip package is installed
		ensure_resource(package,$unzip_package_name,{ensure => 'latest'})
		
		# now extract the zip
		exec {'install-musiccabinet':
		  provider  => 'shell',
		  cwd       => "/home/${subsonic_settings['user']}/apps/",
		  command   => "unzip -jo ${musiccabinet_zip} subsonic-installer-standalone/subsonic* -d ${subsonic_install_dir}",
		  require   => [File [$musiccabinet_zip],Package[$unzip_package_name],Package [$subsonic_package_name]],
		  creates   => "${subsonic_install_dir}/subsonic.bat",
		}
    
    file{"${subsonic_install_dir}/subsonic.sh":
      ensure  => 'present',
      mode    => '0755',
      require => Exec['install-musiccabinet'],
    }
		
		class { 'postgresql::server':
		  ip_mask_allow_all_users    => '0.0.0.0/0',
			listen_addresses           => '127.0.0.1',
			ipv4acls                   => ['host all all 127.0.0.1/32 md5','local all all md5'],
			postgres_password          => $postgres_password,
			
		}
		
		class { 'postgresql::server::contrib':
		  package_name       => 'postgresql-contrib', 
    }
	}
}
