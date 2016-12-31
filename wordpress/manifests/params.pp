# == Class wordpress::params
#
# This class is meant to be called from wordpress.
# It sets variables according to platform.
#
class wordpress::params {
  $version       = 'latest'
  $download_url  = 'http://wordpress.org'
  $install_dir   = 'wordpress'
  

  $settings_all  = {
                    'wp_db_settings'  =>  {
                                            'db_name'         => 'wordpress',
                                            'db_user'         => 'wordpress',
                                            'db_host'         => 'localhost',
                                            'db_password'     => 'password',
                                            'create_db'       => true,
                                            'create_db_user'  => true,
                                          },
                    'wp_app_settings' =>  {
                                            'wp_table_prefix'       => 'wp_',
                                            'wp_additional_config'  => undef,
                                          },
                    'wp_web_settings' =>  {
                                            'apache_conf_enabled'   => true,
                                            'apache_config_file'    => 'wordpress.conf',
                                            'apache_config_dir'     => '/etc/httpd',
                                            'apache_allow_from'     => '192.168.1.0/255.255.255.0',                    
                                          }
                      
                   }
  case $::osfamily {
    'Debian': {
      $doc_root             = '/var/www',
      $wp_owner             = 'www-data',
      $wp_group             = 'www-data',
      $settings_os          = {
                                'apache_config_dir' => '/etc/apache2/conf-enabled',
                              }
    }
    'RedHat': {
			$doc_root             = '/var/www/html',
      $wp_owner             = 'apache',
      $wp_group             = 'apache',
      $settings_os          = {
                                'apache_config_dir' => '/etc/httpd/conf.d',
                              }
    } 
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $default_settings = merge($settings_all,$settings_os)
}
