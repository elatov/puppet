# == Class sophos::params
#
# This class is meant to be called from sophos.
# It sets variables according to platform.
#
class sophos::params {
  $initial_setup  = false
  $setup_dir      = '/tmp'
  $install_dir  = '/opt/sophos-av'
  $version      = '9'
  $settings_all  = {
                    'enable_liveprotection'   =>  true,
                    'enable_onstart'          =>  true,
                    'enable_notifyonupdate'   =>  true,
                    'update_period_minutes'   =>  '1440',
                    'setup_weekly_job'        =>  true,
                    'weekly_job_settings'     =>  {
                                                    'sophos_jobs_dir'     => "${install_dir}/etc/jobs",
                                                    'sophos_weekly_file'  => 'weekly'
                                                  },
                    'enable_email_always'     => true
                   }
                   
  case $::osfamily {
    'Debian': {
      $service_name = 'sav-protect'
      $package_preq = ['linux-headers-amd64','linux-source']
      $settings_os  = {}
    }
    'RedHat': {
#      $package_name = "sav-linux-free-${settings_all['version']}.tgz"
      $service_name = 'sav-protect'
 
      $package_preq = ['kernel-devel']
      $settings_os  = {}
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $default_settings = merge($settings_all,$settings_os)
}
