# == Class subsonic::params
#
# This class is meant to be called from subsonic
# It sets variables according to platform
#
class subsonic::params {
    $subsonic_settings_all          = {'conf' => { 'user'       => 'test',
                                                   'max_memory' => '150', 
                                                   'host'       => $::ipaddress,
                                                 }
                                      }
  case $::osfamily {
    'Redhat': {
      ### Package
      $subsonic_package_name        = 'subsonic-5.0.rpm'
      $subsonic_musiccabinet_zip    = 'subsonic-installer-standalone.zip'
      ### Service
      $subsonic_service_name        = 'subsonic'
      ### Dirs
      $subsonic_config_dir          = '/etc/sysconfig'
      $subsonic_install_dir         = '/usr/share/subsonic'
      $subsonic_home                = '/var/subsonic'
      ### settings
      $subsonic_settings_os         = { 'pkgs_pre'      => ['java-1.8.0-openjdk-headless','unzip'],
                                        'enable_muscab' => false,
                                        'pgsql_pass'    => 'subsonic',
                                      }
      
      if (versioncmp($::operatingsystemmajrelease, '7') >= 0) {
        $subsonic_config_file       = 'subsonic-sysconf-systemd'
        $subsonic_service_dir       = '/usr/lib/systemd/system'
        $subsonic_service_file      = 'subsonic.service'
      }else{
        $subsonic_config_file       = 'subsonic-sysconf-init'
        $subsonic_service_dir       = '/etc/init.d'
        $subsonic_service_file      = 'subsonic.init'
      }
      
    }
    'Debian': {
      $subsonic_config_dir          = '/etc/default'
      $subsonic_package_name        = 'subsonic'
      $subsonic_service_name        = 'subsonic'
      $subsonic_service_file        = 'subsonic.init'
      $subsonic_service_dir         = '/etc/init.d'
      $subsonic_settings_os         = { 'pkg_pre'  => ['openjdk-8-jdk','unzip']
                                      }
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }
  $subsonic_default_settings = merge($subsonic_settings_all,$subsonic_settings_os)
}
