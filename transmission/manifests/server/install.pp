# See README.md for further information on usage.
class transmission::server::install inherits transmission::server {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'server-transmission-package':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
