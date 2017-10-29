# == Class lynis::params
#
# This class is meant to be called from lynis.
# It sets variables according to platform.
#
class lynis::params {
  $settings_all  =  { 'cron_enabled'  => true,
                      'cron_email_to' => "root",
                      'tests'         => {
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
                                           'AUTH-9328'               =>  true,
                                           'FILE-6310'               =>  true,
                                           'BANN-7126'               =>  true,
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
                                                'ACCT-9630'               => true,
                                                'ACCT-9630_cron'          => true,
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
                                                'ACCT-9622'               => true,
                                                'ACCT-9626'               => true,
                                                'ACCT-9626_enable_cron'   => true,
                                              'KRNL-6000_enabled_options' =>  {
                                                                                'kernel.core_uses_pid'                      => '1',
                                                                                'net.ipv4.conf.all.rp_filter'               => '1',
                                                                                'net.ipv4.conf.default.accept_source_route' => '0',
                                                                              },
                                                'HRDN-7222'                 =>  true,                              
                                                'HRDN-7222_binaries'      => ['/usr/bin/gcc-4.9',
                                                                              '/usr/bin/as',
                                                                              '/usr/bin/g++-4.9'
                                                                             ],
                                                'HRDN-7230'               =>  true,                                                                             
                                                'HRDN-7230_soph_settings' => {
                                                                              'override_settings' => {
                                                                                                    'weekly_job_parameters' => {
                                                                                                                                'exclude' => ["/tmp"],
                                                                                                    }
                                                                              }
                                                }
                                                                            
                                               },
                        'disabled_tests'    => ['AUTH-9286','FILE-6310','NETW-3032','HTTP-6641']
      }
    }
    'RedHat': {
      $settings_os  =  { 
                      'yum_repo_enabled' =>  true,
                      'tests'         =>  { 
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
                                                                            'net.ipv6.conf.default.accept_redirects'  => '0',
                                                                            'kernel.dmesg_restrict'                   => '1'
                                                                           },
                                            'KRNL-6000_disabled_options'=> ['net.ipv4.tcp_timestamps'],
                                            'HRDN-7222'                 =>  true,
                                            'HRDN-7222_binaries'        => ['/usr/bin/gcc','/usr/bin/as']
                      }
      }
      $conf_dir     = '/etc/lynis'
      $conf_file    = 'default.prf'
      $package_name = 'lynis'
      $service_name = 'lynis'
    }
    'FreeBSD': {
      $settings_os  = {'tests'  => {
                                    'SHLL-6202'               => true,
                                    'ACCT-2754'               => true,
                                    'HRDN-7222'               => true,
                                    'HRDN-7222_binaries'      => [
                                                                  '/usr/bin/as',
                                                                  '/usr/local/bin/as',
                                                                  '/usr/local/bin/gcc47',
                                                                 ],
                                    'KRNL-6000'                =>  true,
                                    'KRNL-6000_enabled_options'=>  {
                                                                    'hw.kbd.keymap_restrict_change'           => '4',
                                                                    'net.inet.icmp.drop_redirect'             => '1',
                                                                    'net.inet.ip.check_interface'             => '1',
                                                                    'net.inet.ip.process_options'             => '0',
                                                                    'net.inet.ip.random_id'                   => '1',
                                                                    'net.inet.ip.redirect '                   => '0',
                                                                    'net.inet.tcp.always_keepalive'           => '0',
                                                                    'net.inet.tcp.blackhole'                  => '2',
                                                                    'net.inet.tcp.drop_synfin'                => '1',
                                                                    'net.inet.tcp.icmp_may_rst'               => '0',
                                                                    'net.inet.tcp.nolocaltimewait'            => '1',
                                                                    'net.inet.tcp.path_mtu_discovery'         => '0',
                                                                    'net.inet.udp.blackhole'                  => '1',
                                                                    'net.inet6.icmp6.rediraccept'             => '0',
                                                                    'net.inet6.ip6.redirect'                  => '0',
                                                                    'security.bsd.hardlink_check_gid'         => '1',
                                                                    'security.bsd.hardlink_check_uid'         => '1',
                                                                    'security.bsd.see_other_gids'             => '0',
                                                                    'security.bsd.see_other_uids'             => '0',
                                                                    'security.bsd.stack_guard_page'           => '1',
                                                                    'security.bsd.unprivileged_proc_debug'    => '0',
                                                                    'security.bsd.unprivileged_read_msgbuf'   => '0',
                                                                    },
                                   }
      }
      $conf_dir     = '/usr/local/etc/lynis'
      $conf_file    = 'default.prf'
      $package_name = 'lynis'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }  
  }
  $default_settings = deep_merge($settings_all,$settings_os)
}
