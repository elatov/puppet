# == Class nfs::client::service
#
# This class is meant to be called from nfs::client
# It ensure the service is running
#
class nfs::client::service inherits nfs::params{

  service { $nfs_client_service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
