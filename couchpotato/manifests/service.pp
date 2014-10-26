class couchpotato::service {
  service { $couchpotato::service_name:
    ensure     => running,
    enable     => true,
    require    => Class['couchpotato::config'],
  }
}