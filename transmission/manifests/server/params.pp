# See README.md for further information on usage.
class transmission::server::params {

  # Server parameters
  # Config dir
  $server_config_dir_ensure           = 'directory'
  #config file
  $server_config_file_ensure          = 'present'
  #package
  $server_package_ensure              = 'latest'
  # service
  $server_service_ensure              = 'running'
  $server_service_file_ensure         = 'present'
  #username
  $server_username                    = 'test'
  $server_username_ensure             = 'present'
  # log_dir
  $server_log_dir                     = '/var/log/transmission'
  $server_log_dir_ensure              = 'directory'
  # log_file
  $server_log_file                    = 'transmission.log'
  $server_log_file_ensure             = 'present'
  ## transmission settings
  $server_transmission_settings       = {
                                        'incomplete-dir'   => '/data/t_down',
                                        'download-dir'     => '/data/t_down/tv',
                                        'watch-dir'        => '/data/t_down'
                                        }
  
  case $::osfamily {
    'Redhat': {
      $server_config_dir            = '/var/lib/transmission/.config'
      $server_config_file           = 'settings.json'
      $server_package_name          = 'transmission-daemon'
      $server_service_name          = 'transmission-daemon'
      $server_service_file          = 'transmission-daemon.service'
      if $::operatingsystemmajrelease >= 7 {
        $server_service_dir         = '/usr/lib/systemd/system'
      }else{
        $server_service_dir         = '/etc/init.d'
      }
      
    }
    'Debian': {
      $server_config_dir            = '/var/lib/transmission/.config'
      $server_package_name          = 'transmission-daemon'
      $server_service_name          = 'transmission-daemon'
      $service_file                 = 'transmission-daemon.init'
      $server_service_dir           = '/etc/init.d'
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }

}
