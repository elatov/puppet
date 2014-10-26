# == Class plexms::install
#
class plexms::install inherits plexms::params {
  
  case $::osfamily {
    'Debian': {
      
			apt::source { $plexms_apt_source:
				location    => 'http://shell.ninthgate.se/packages/debian',
				release     => $::lsbdistcodename,
				repos       => 'main',
				include_src => false,
			}
      
      ensure_resource ('package',$plexms_package_name,{ 'ensure'=> 'latest',require => Apt::Source[$plexms_apt_source] })
      
    }
    'RedHat': {
      
      if ($plexms_use_rpm){
        ensure_resource ('file',
                         "/home/${plexms_settings['User']}/apps",
                         {'ensure'  => 'directory',
                          'owner'   => $plexms_settings['User'],
                          'group'   => $plexms_settings['User']})

				# let's get the RPM from the puppet master
				file {"get-${plexms_rpm_name}":
					ensure => 'present',
					path   => "/home/${plexms_settings['User']}/apps/${plexms_rpm_name}",
					source => "puppet:///modules/plexms/${plexms_rpm_name}",
					require => File ["/home/${plexms_settings['User']}/apps"],
				}->
				package {$plexms_package_name:
	        provider => 'rpm',
	        source   => "/home/${plexms_settings['User']}/apps/${plexms_rpm_name}",
        }
        
        
      } else {
        
				yumrepo { $plexms_yum_repo :
					baseurl   => "http://plex.r.worldssl.net/PlexMediaServer/fedora-repo/release/\$basearch/",
					descr     => "Plex Repository for Fedora",
					enabled   => 1,
					gpgcheck  => 1,
					gpgkey    => "https://plex.tv/plex_pub_key.pub",
				}
								
				ensure_resource ('package',$plexms_package_name,{ 'ensure'=> 'latest',require => Yumrepo[$plexms_yum_repo] })
        
      }
			
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
	# change ownership of /var/lib/plexmediaserver dir
	file{$plexms_home:
		ensure => 'directory',
		owner  => $plexms_settings['User'],
		group  => $plexms_settings['User'],
		require => Package [$plexms_package_name]
	}
}
