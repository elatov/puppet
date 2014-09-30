class zabbix::repo::debian ($apt_pin = '510', $version = '2.2'){
  apt::source { 'zabbix':
    location   => "http://repo.zabbix.com/zabbix/${version}/debian/",
    release    => 'wheezy',
    repos      => 'main',
    key        => '79EA5ED4',
    key_source => 'http://repo.zabbix.com/zabbix-official-repo.key',
    pin        => $apt_pin,
  }
}