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
                                            'KRNL-6000_disabled_options'=> ['net.ipv4.tcp_timestamps'],
                                            'HRDN-7222'                 =>  true,
                                            'HRDN-7222_binaries'        => ['/usr/bin/gcc','/usr/bin/as']
                      }
                    }
  case $::osfamily {
    'Debian': {
      $package_name = 'lynis'
      $service_name = 'lynis'
      $conf_dir     = '/etc/lynis'
      $conf_file    = 'default.prf'
      $settings_os  = { 'apt_repo_enabled'  =>  true,
                        'tests'             => {
                                                'BOOT-5122'               => true,
                                                'BOOT-5122_user'          => 'admin',
                                                'BOOT-5122_pdf12_pw'      => 'grub.pbkdf2.sha512.10000.',
                                                'AUTH-9262'               => true,
                                                'PKGS-7370'               => true,
                                                'PKGS-7370_cron'          => 'weekly',
                                                'HTTP-6640'               => true,
                                                'HTTP-6640_email'         => 'test@localhost',
                                                'HTTP-6640_logdir'        => '/var/log/apache2/evasive',
                                                'HTTP-6643'               => true,
                                                'SSH-7408_enabled_tests'  => { 
                                                                            'UsePrivilegeSeparation'  =>  'sandbox',
                                                                         },
                                                'PHP-2376'                => true,
                                                'ACCT-9626'               => true,
                                                'ACCT-9626_enable_cron'   => true,
                                              'KRNL-6000_enabled_options' =>  {
                                                                                'kernel.core_uses_pid'                      => '1',
                                                                                'net.ipv4.conf.all.rp_filter'               => '1',
                                                                                'net.ipv4.conf.default.accept_source_route' => '0',
                                                                              },
                                                'HRDN-7222_binaries'      => ['/usr/bin/gcc','/usr/bin/as','/usr/bin/g++']
                                               },
                        'disabled_tests'    => ['AUTH-9286','FILE-6310','NETW-3032','HTTP-6641']
      }
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
  $default_settings = deep_merge($settings_all,$settings_os)
}
