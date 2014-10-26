# == Class nfs::server::service
#
# This class is meant to be called from nfs
# It ensure the service is running
#
class nfs::server::service inherits nfs::params{

  service { $nfs_server_service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
