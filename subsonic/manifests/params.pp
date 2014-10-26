# == Class subsonic::params
#
# This class is meant to be called from subsonic
# It sets variables according to platform
#
class subsonic::params {
  case $::osfamily {
    'Redhat': {
      $subsonic_config_dir          = '/etc/sysconfig'
      $java_jdk_package_name        = 'java-1.7.0-openjdk'
      $unzip_package_name           = 'unzip'
      $subsonic_package_name        = 'subsonic'
      $subsonic_service_name        = 'subsonic'
      $subsonic_rpm                 = 'subsonic-4.9.rpm'
      $subsonic_settings            = {
                                      'user'       => 'test',
                                      'max_memory' => '150', 
                                      'host'       => $::ipaddress,
                                      }
      
      $enable_musiccabinet          = true
      $musiccabinet_zip             = 'subsonic-installer-standalone.zip'
      $subsonic_install_dir         = '/usr/share/subsonic'
      $subsonic_home                = '/var/subsonic'
      $postgres_password            = 'subsonic'
      
      if $::operatingsystemmajrelease >= 7 {
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
      $java_jdk_package_name        = 'openjdk-7-jdk'
      $subsonic_config_dir          = '/etc/default'
      $subsonic_package_name        = 'subsonic'
      $subsonic_service_name        = 'subsonic'
      $subsonic_service_file        = 'subsonic.init'
      $subsonic_service_dir         = '/etc/init.d'
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }
}
