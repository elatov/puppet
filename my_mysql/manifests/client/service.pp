# == Class my_mysql::client::service
#
# This class is meant to be called from my_mysql::client
# It ensure the service is running
#
class my_mysql::client::service {

  service { $my_mysql::client_service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
