# Class: dis_ipv6
#
# This module manages dis_ipv6
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class dis_ipv6 {
	case $::operatingsystem {
	    /(?i:CentOS)/: { 
	      if ($::operatingsystemmajrelease == '7') { 
					augeas { "sysctl_conf-net.ipv6.conf.all.disable_ipv6":
					  incl    => "/etc/sysctl.d/90-dis_ipv6.conf",
						context => "/files/etc/sysctl.d/90-dis_ipv6.conf",
            lens    => "Simplevars.lns",
						onlyif  => "get net.ipv6.conf.all.disable_ipv6 != '1'",
						changes => "set net.ipv6.conf.all.disable_ipv6 '1'",
						notify  => Exec["sysctl"],
					}
					
					augeas { "sysctl_conf-net.ipv6.conf.default.disable_ipv6":
					  incl    => "/etc/sysctl.d/90-dis_ipv6.conf",
            context => "/files/etc/sysctl.d/90-dis_ipv6.conf",
            lens    => "Simplevars.lns",
            onlyif  => "get net.ipv6.conf.default.disable_ipv6 != '1'",
            changes => "set net.ipv6.conf.default.disable_ipv6 '1'",
            notify  => Exec["sysctl"],
          }
          
          augeas { "sysctl_conf-net.core.rmem_max":
            incl    => "/etc/sysctl.d/91-perf.conf",
            context => "/files/etc/sysctl.d/91-perf.conf",
            lens    => "Simplevars.lns",
            onlyif  => "get net.core.rmem_max != '4194304'",
            changes => "set net.core.rmem_max '4194304'",
            notify  => Exec["sysctl"],
          }
          
          augeas { "sysctl_conf-net.core.wmem_max":
            incl    => "/etc/sysctl.d/91-perf.conf",
            context => "/files/etc/sysctl.d/91-perf.conf",
            lens    => "Simplevars.lns",
            onlyif  => "get net.core.wmem_max != '1048576'",
            changes => "set net.core.wmem_max '1048576'",
            notify  => Exec["sysctl"],
          }
					
					augeas { "sshd_config-ipv6":
						context => "/files/etc/ssh/sshd_config",
						changes =>  [
						            "set AddressFamily inet",
						            ],
						notify => Service["sshd"],
					}

          augeas {'disable_ipv6_host_entry':
	          incl    => "/etc/hosts",
	          lens    => "Hosts.lns",
	          context => "/files/etc/hosts",
	          changes => "rm *[ipaddr = '::1']",
	          onlyif  => "match *[ipaddr = '::1'] size >= 1"
          }
	      } else { 
#	        class { 'augeasproviders::instances':
#	          sysctl_hash => { 'net.ipv6.conf.all.disable_ipv6' => { 
#	                            'value' => '1',
#	                         },
#	                         'net.ipv6.conf.default.disable_ipv6' => { 
#	                            'value' => '1',
#	                         },
#	         },
#	         sshd_config_hash => { 'AddressFamily' => { 
#                              'ensure' => 'present',
#                               'value' => "inet",
#                               notify => Service["sshd"],
#                               },
#           }, 
#	        }

          augeas { "sshd_config-ipv6":
            context => "/files/etc/ssh/sshd_config",
            changes =>  [
                        "set AddressFamily inet",
                        ],
            notify => Service["sshd"],
          }
	      }
	    }
	    /(?i:fedora)/: { 
        augeas { "sysctl_conf-net.ipv6.conf.all.disable_ipv6":
            incl    => "/etc/sysctl.d/90-dis_ipv6.conf",
            context => "/files/etc/sysctl.d/90-dis_ipv6.conf",
            lens    => "Simplevars.lns",
            onlyif  => "get net.ipv6.conf.all.disable_ipv6 != '1'",
            changes => "set net.ipv6.conf.all.disable_ipv6 '1'",
            notify  => Exec["sysctl"],
          }
          
          augeas { "sysctl_conf-net.ipv6.conf.default.disable_ipv6":
            incl    => "/etc/sysctl.d/90-dis_ipv6.conf",
            context => "/files/etc/sysctl.d/90-dis_ipv6.conf",
            lens    => "Simplevars.lns",
            onlyif  => "get net.ipv6.conf.default.disable_ipv6 != '1'",
            changes => "set net.ipv6.conf.default.disable_ipv6 '1'",
            notify  => Exec["sysctl"],
          }
          
          augeas { "sshd_config-ipv6":
            context => "/files/etc/ssh/sshd_config",
            changes =>  [
                        "set AddressFamily inet",
                        ],
            notify => Service["sshd"],
          }
	    }
	    /(?i:Debian)/: {
#	      class { 'augeasproviders::instances':
#	         sysctl_hash       => { 'net.ipv6.conf.all.disable_ipv6' => { 
#	                                'value'   => '1',
#	                                'target'  => "/etc/sysctl.d/90-dis_ipv6.conf",
#	                              }
#	         },
#	         sshd_config_hash  => { 'AddressFamily' => { 
#                                 'ensure' => 'present',
#                                 'value'  => "inet",
#                                 'notify' => Service["sshd"],
#                                },
#           },   
#	      }
        augeas { "sysctl_conf-net.ipv6.conf.all.disable_ipv6":
            incl    => "/etc/sysctl.d/90-dis_ipv6.conf",
            context => "/files/etc/sysctl.d/90-dis_ipv6.conf",
            lens    => "Simplevars.lns",
            onlyif  => "get net.ipv6.conf.all.disable_ipv6 != '1'",
            changes => "set net.ipv6.conf.all.disable_ipv6 '1'",
            notify  => Exec["sysctl"],
        }
        
        augeas { "sshd_config-ipv6":
            context => "/files/etc/ssh/sshd_config",
            changes =>  [
                        "set AddressFamily inet",
                        ],
            notify => Service["sshd"],
          }
          
				kmod::blacklist { 'ipv6': }
				augeas {'disable_ipv6_netconfig_udp':
				  incl    => "/etc/netconfig",
          lens    => "Spacevars.lns",
          context => "/files/etc/netconfig",
          changes => "rm udp6",
          onlyif  => "match udp6 size >= 1"
        }

        augeas {'disable_ipv6_netconfig_tcp':
          incl    => "/etc/netconfig",
          lens    => "Spacevars.lns",
          context => "/files/etc/netconfig",
          changes => "rm tcp6",
          onlyif  => "match tcp6 size >= 1"
        }
        $hosts_to_remove = ['ip6-allnodes','ip6-allrouters']
        ensure_resource ('host',$hosts_to_remove,{ 'ensure' => "absent"})

        augeas {'disable_ipv6_host_entry':
          incl    => "/etc/hosts",
          lens    => "Hosts.lns",
          context => "/files/etc/hosts",
          changes => "rm *[ipaddr = '::1']",
          onlyif  => "match *[ipaddr = '::1'] size >= 1"
        }
        
	    }
      /(?i:Ubuntu)/: {
        augeas { "sysctl_conf-net.ipv6.conf.all.disable_ipv6":
            incl    => "/etc/sysctl.d/90-dis_ipv6.conf",
            context => "/files/etc/sysctl.d/90-dis_ipv6.conf",
            lens    => "Simplevars.lns",
            onlyif  => "get net.ipv6.conf.all.disable_ipv6 != '1'",
            changes => "set net.ipv6.conf.all.disable_ipv6 '1'",
        } ->

        augeas { "sysctl_conf-net.ipv6.conf.default.disable_ipv6":
            incl    => "/etc/sysctl.d/90-dis_ipv6.conf",
            context => "/files/etc/sysctl.d/90-dis_ipv6.conf",
            lens    => "Simplevars.lns",
            onlyif  => "get net.ipv6.conf.default.disable_ipv6 != '1'",
            changes => "set net.ipv6.conf.default.disable_ipv6 '1'",
        } ->

        augeas { "sysctl_conf-net.ipv6.conf.lo.disable_ipv6":
            incl    => "/etc/sysctl.d/90-dis_ipv6.conf",
            context => "/files/etc/sysctl.d/90-dis_ipv6.conf",
            lens    => "Simplevars.lns",
            onlyif  => "get net.ipv6.conf.lo.disable_ipv6 != '1'",
            changes => "set net.ipv6.conf.lo.disable_ipv6 '1'",
            notify  => Exec["ipv6-sysctl-system"],
        }

        augeas { "sshd_config-ipv6":
            context => "/files/etc/ssh/sshd_config",
            changes =>  [
                        "set AddressFamily inet",
                        ],
            notify => Service["sshd"],
          }
        $hosts_to_remove = ['ip6-allnodes','ip6-allrouters']
        ensure_resource ('host',$hosts_to_remove,{ 'ensure' => "absent"})

        augeas {'disable_ipv6_host_entry':
          incl    => "/etc/hosts",
          lens    => "Hosts.lns",
          context => "/files/etc/hosts",
          changes => "rm *[ipaddr = '::1']",
          onlyif  => "match *[ipaddr = '::1'] size >= 1"
        }
        file { "file-99force-ipv4":
          path    => '/etc/apt/apt.conf.d/99force-ipv4',
          ensure  => 'file'
        }
        file_line { "apt-99force-ipv4":
          path    => '/etc/apt/apt.conf.d/99force-ipv4',
          line    => "Acquire::ForceIPv4 \"true\";",
          require => File['file-99force-ipv4']
        }
      }
	    /(?i:FreeBSD)/: {
	      augeas {'disable_ipv6_host_entry':
          incl    => "/etc/hosts",
          lens    => "Hosts.lns",
          context => "/files/etc/hosts",
          changes => "rm *[ipaddr = '::1']",
          onlyif  => "match *[ipaddr = '::1'] size >= 1"
        }
	      augeas { "sshd_config-ipv6":
            context => "/files/etc/ssh/sshd_config",
            changes =>  [
                        "set AddressFamily inet",
                        ],
            notify => Service["sshd"],
          }
        
				file_line { "ip6addrctl_e_in_rc_conf":
					path => '/etc/rc.conf',
					line => "ip6addrctl_enable=\"NO\"",
				}
				
				file_line { "ip6addrctl_p_in_rc_conf":
          path => '/etc/rc.conf',
          line => "ip6addrctl_policy=\"ipv4_prefer\"",
        }
        
        file_line { "ip6_a_in_rc_conf":
          path => '/etc/rc.conf',
          line => "ipv6_activate_all_interfaces=\"NO\"",
        }
        
				file_line { "ip6_n_in_rc_conf":
					path => '/etc/rc.conf',
					line => "ipv6_network_interfaces=\"none\"",
				}
	    }
	    default: {
	      augeas { "sshd_config-ipv6":
            context => "/files/etc/ssh/sshd_config",
            changes =>  [
                        "set AddressFamily inet",
                        ],
            notify => Service["sshd"],
        }
	    }
	  }
	  
	service { "sshd":
    name    => $operatingsystem ? {
			/(?i:Debian|Ubuntu)/ => "ssh",
			default => "sshd",},
#    require => Class["augeasproviders::instances"],
    enable  => true,
		ensure  => running,
	}
	exec { "sysctl -p":
		alias       => "sysctl",
		refreshonly => true,
		path    => ['/usr/bin', '/usr/sbin',],
	}
  exec { "ipv6-sysctl --system":
    alias       => "ipv6-sysctl-system",
    refreshonly => true,
    path        => ['/usr/bin', '/usr/sbin','/sbin'],
  }
}
