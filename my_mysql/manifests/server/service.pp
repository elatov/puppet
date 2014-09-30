# == Class my_mysql::server::service
#
# This class is meant to be called from my_mysql
# It ensure the service is running
#
class my_mysql::server::service {

  service { $my_mysql::server::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
