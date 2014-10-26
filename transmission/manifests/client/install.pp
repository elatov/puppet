# See README.md for further information on usage.
class transmission::client::install inherits transmission::client {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'client-transmission-package':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
