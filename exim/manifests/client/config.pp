# == Class exim::client::config
#
# This class is called from exim::client
#
class exim::client::config {

   if ($exim::client::settings['add_user'] != undef) {
		if ($::osfamily == 'FreeBSD') {
      User <| title == "${exim::client::settings['add_user']}" |> { groups +> ['mail'] }
    }elsif ($::osfamily == 'Debian'){
      User <| title == "${exim::client::settings['add_user']}" |> { groups +> ['adm'] }
		}else{
		  User <| title == "${exim::client::settings['add_user']}" |> { groups +> ['mail','exim'] }
		}
  }

   if ($exim::client::settings['aliases']) {
      exim::aliases{$exim::client::settings['aliases']:
          config_file     => $exim::client::settings['aliases_file'],
          alias_recipient => $exim::client::settings['alias_recipient'],
        }
     # case $::osfamily {
     #   'Archlinux': {
     #     exim::aliases{$exim::client::settings['aliases']:
     #       config_file    => '/etc/mail/aliases',
     #       alias_recipient => $exim::client::settings['alias_recipient'],
     #    }
     #   }
     #   # default: {
     #   #  exim::aliases{$exim::client::settings['aliases']:
     #   #    config_file     => '/etc/aliases',
     #   #    alias_recipient => $exim::client::settings['alias_recipient'],
     #   #  }
     #   # }
     # }

  }
    
  file { $exim::client::config_dir:
    ensure  => 'directory',
  }
  
  file { $exim::client::config_file:
    ensure  => 'present',
    path    => "${exim::client::config_dir}/${exim::client::config_file}",
    content => template("exim/exim.conf.${::osfamily}.erb"),
    require => File[$exim::client::config_dir],
  }

  case $::osfamily {
    'FreeBSD': {
      ### Stop the Sendmail service from running
      ensure_resource('service', $exim::client::settings['stopped_services'], {
        ensure => 'stopped' })

      ### Configure rc.conf to disable sendmail and to enable exim
      $rc_conf_keys = keys($exim::client::settings['rc_conf'])

      exim::client::settings { $rc_conf_keys:
        config_file   => $exim::client::rc_conf_file,
        settings_hash => $exim::client::settings['rc_conf'],
      }

      ### configure periodic.conf to disable the sendmail jobs
      $periodic_conf_keys = keys($exim::client::settings['periodic_conf'])

      file { $exim::client::periodic_conf_file:
        ensure => 'present',
      } ->
      exim::client::settings { $periodic_conf_keys:
        config_file   => $exim::client::periodic_conf_file,
        settings_hash => $exim::client::settings['periodic_conf'],
      }

      ### Configure the system to use exim through the mailer.conf file
      file { $exim::client::mailer_conf_file:
        ensure => "present",
        source => "puppet:///modules/exim/mailer.conf",
        owner  => 'root',
        group  => 'wheel',
      }

      ### Setup the logs to be rotated
      newsyslog { '/var/log/exim/mainlog':
        owner => 'mailnull',
        group => 'mail',
        mode  => '640',
        keep  => '7',
        size  => '*',
        when  => '@T00',
        flags => 'N',
      }

      newsyslog { '/var/log/exim/paniclog':
        owner => 'mailnull',
        group => 'mail',
        mode  => '640',
        keep  => '7',
        size  => '*',
        when  => '@T00',
        flags => 'N',
      }

      newsyslog { '/var/log/exim/rejectlog':
        owner => 'mailnull',
        group => 'mail',
        mode  => '640',
        keep  => '7',
        size  => '*',
        when  => '@T00',
        flags => 'N',
      }
    }
    'RedHat': {
      exec { "${module_name}-update-alt-mta":
        command => '/sbin/alternatives --set mta /usr/sbin/sendmail.exim',
        unless  =>
          '/sbin/alternatives --list | /bin/grep mta | /bin/grep exim'
      }
      service { $exim::client::settings['stopped_services']:
        ensure => "stopped",
      } ->
      package { $exim::client::settings['absent_packages']:
        ensure => "absent",
      }
    }
    'Debian': {
      service { $exim::client::settings['stopped_services']:
        ensure => "stopped",
      } ->
      package { $exim::client::settings['absent_packages']:
        ensure => "absent",
      }

      $keys = keys($exim::client::settings['config'])

      exim::client::settings { $keys:
        config_file     => "${exim::client::config_dir}/${exim::client::exim_client_template_conf_file}",
        settings_hash   => $exim::client::settings['config'],
      }~>
      exec {exim-client-update-config:
        path        => ['/sbin','/usr/sbin','/usr/bin','/bin'],
        command     => 'update-exim4.conf',
        refreshonly => true,
      }
    }
  }
  
}