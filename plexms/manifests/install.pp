# == Class plexms::install
#
class plexms::install {
  
  case $::osfamily {
    'Debian': {
      
			apt::source { $plexms::settings['apt_source']:
				location    => 'http://shell.ninthgate.se/packages/debian',
				release     => $::lsbdistcodename,
				repos       => 'main',
				include_src => false,
			}
      
      ensure_resource ('package',$plexms::package_name,{ 'ensure' => 'present',
                                                         require => Apt::Source[$plexms::settings['apt_source']] })
      
    }
    'RedHat': {
      
      if ( $plexms::settings['use_rpm'] == true ){
        ensure_resource('file','/usr/local/apps',{ensure => 'directory'})

				# let's get the RPM from the puppet master
				file { "get-${plexms::settings['rpm_name']}":
					ensure => 'present',
					path   => "/usr/local/apps/${plexms::settings['rpm_name']}",
					source => "puppet:///modules/plexms/${plexms::settings['rpm_name']}",
					require => File ['/usr/local/apps'],
				}->
				package { $plexms::package_name:
	        provider => 'rpm',
	        source   => "/usr/local/apps/${plexms::settings['rpm_name']}",
        }
      } else {
				yumrepo { PlexRepo :
					baseurl   => "http://plex.r.worldssl.net/PlexMediaServer/fedora-repo/release/\$basearch/",
					descr     => "Plex Repository for Fedora",
					enabled   => 1,
					gpgcheck  => 1,
					gpgkey    => "https://plex.tv/plex_pub_key.pub",
				}
				ensure_resource ('package',$plexms::package_name,{ 'ensure'=> 'present',require => Yumrepo['PlexRepo'] })
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  ensure_resource ('user',$plexms::settings['conf']['User'],{ 'ensure'=> 'present' })
	# change ownership of /var/lib/plexmediaserver dir
	file{ $plexms::home_dir:
		ensure => 'directory',
		owner  => $plexms::settings['conf']['User'],
		group  => $plexms::settings['conf']['Group'],
		require => [Package [$plexms::package_name], User[$plexms::settings['conf']['User']]]
	}
}
