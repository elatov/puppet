# == Class nfs::server::config
#
# This class is called from nfs::server
#
class nfs::server::config {

  file { $nfs::server::exports_file:
    ensure  => 'present',
    path    => $nfs::server::exports_file,
    content => template("nfs/exports.erb"),
  }~>
  exec {"${::modulename}-refresh-exportfs":
    path  => ['/sbin','/usr/sbin'],
    provider => 'shell',
    refreshonly => true,
    command     => 'exportfs -ra',
  }

}
