# == Class my_mysql::service
#
# This class is meant to be called from my_mysql
# It ensure the service is running
#
class my_mysql::service {

  service { $my_mysql::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
