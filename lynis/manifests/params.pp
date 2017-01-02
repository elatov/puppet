# == Class lynis::params
#
# This class is meant to be called from lynis.
# It sets variables according to platform.
#
class lynis::params {
  $settings_all  =  { 'cron_enabled'  => true,
                      'cron_email_to' => "root",
                      'tests'         =>  { 'AUTH-9328'               =>  true,
                                            'FILE-6310'               =>  true,
                                            'STRG-1840'               =>  true,
                                            'STRG-1846'               =>  true,
                                            'NETW-3032'               =>  true,
                                            'SSH-7408'                =>  true,
                                            'SSH-7408_enabled_tests'  => {  'UseDNS'                =>  'yes',
                                                                            'X11Forwarding'         =>  'no',
                                                                            'AllowAgentForwarding'  =>  'no',
                                                                            'AllowTcpForwarding'    =>  'no'
                                                                         },
                                            'SSH-7408_disabled_tests' => ['ClientAliveCountMax',
                                                                          'Compression',
                                                                          'LogLevel',
                                                                          'MaxAuthTries',
                                                                          'MaxSessions',
                                                                          'PermitRootLogin',
                                                                          'Port',
                                                                          'TCPKeepAlive',
                                                                          'UseDNS'
                                                                         ],
                                            'BANN-7126'                =>  true,
                                            'ACCT-9622'                =>  true,
                                            'ACCT-9630'                =>  true,
                                            'HRDN-7230'                =>  true,
                                            'KRNL-6000'                =>  true,
                                            'KRNL-6000_enabled_options'=>  {
                                                                            'kernel.kptr_restrict'                    => '2',
                                                                            'kernel.sysrq'                            => '0',
                                                                            'net.ipv4.conf.all.accept_redirects'      => '0',
                                                                            'net.ipv4.conf.all.log_martians'          => '1',
                                                                            'net.ipv4.conf.all.send_redirects'        => '0',
                                                                            'net.ipv4.conf.default.accept_redirects'  => '0',
                                                                            'net.ipv4.conf.default.log_martians'      => '1',
                                                                            'net.ipv6.conf.all.accept_redirects'      => '0',
                                                                            'net.ipv6.conf.default.accept_redirects'  => '0'
                                                                           },
                                            'KRNL-6000_disabled_options'=> ['net.ipv4.tcp_timestamps']
                      }
                    }
  case $::osfamily {
    'Debian': {
      $package_name = 'lynis'
      $service_name = 'lynis'
    }
    'RedHat': {
      $settings_os  = {'yum_repo_enabled' =>  true}
      $conf_dir     = '/etc/lynis'
      $conf_file    = 'default.prf'
      $package_name = 'lynis'
      $service_name = 'lynis'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }  
  }
  $default_settings = merge($settings_all,$settings_os)
}
