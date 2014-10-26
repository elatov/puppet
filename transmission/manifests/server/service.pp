# See README.md for further information on usage.
class transmission::server::service inherits transmission::server {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'transmission-daemon':
    ensure => $service_ensure,
    name   => $service_name,
  }

}
