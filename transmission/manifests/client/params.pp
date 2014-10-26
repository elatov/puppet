# See README.md for further information on usage.
class transmission::client::params {

  # client parameters
  # Config dir
  $client_config_dir_ensure           = 'directory'
  #config file
  $client_config_file_ensure          = 'present'
  #package
  $server_package_ensure              = 'latest'
  #username
  $client_username                    = 'test'
  $client_username_ensure             = 'present'
  
  # password
  $client_password                    = 'passwd'
  
  # transmission client settings
  $client_transmission_settings     = {
                                        'username'   => $client_username,
                                        'password'     => $client_password,
                                      }
  
  case $::osfamily {
    'Redhat': {
      $client_config_dir            = "/home/${client_username}"
      $client_config_file           = 'netrc'
      $client_package_name          = 'transmission-common'
            
    }
    'Debian': {
      $client_config_dir            = "/home/${client_username}"
      $client_config_file           = 'netrc'
      $client_package_name          = 'transmission-common'
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }

}
