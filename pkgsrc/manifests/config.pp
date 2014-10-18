# == Class pkgsrc::config
#
# This class is called from pkgsrc
#
class pkgsrc::config {

  ensure_resource (file,$pkgsrc::home,{ensure => 'directory'})
  
  exec { "${module_name}-wget-pkgsrc":
    path    => ['bin','/usr/bin'],
    cwd     => '/root/apps',
    command => "wget http://${pkgsrc::settings['url']}/bootstrap-${pkgsrc::settings['version']}-x86_64.tar.gz",
    require => File['/root/apps'],
    creates  => "/root/apps/bootstrap-${pkgsrc::settings['version']}-x86_64.tar.gz",
  }~>
  exec { "${module_name}-extract-pkgsrc":
    path        => ['bin','/usr/bin'],
    cwd         => '/root/apps',
    command     => "tar xzf /root/apps/bootstrap-${pkgsrc::settings['version']}-x86_64.tar.gz -C /",
    require     => File[$pkgsrc::settings['home']],
    refreshonly => true,
    creates     => "/opt/local/etc"
 }~>
 exec { "${module_name}-rebuild-pkgsrc_index":
    path        => ['/opt/local/sbin','/opt/local/bin'],
    command     => "pkg_admin rebuild",
    require     => File[$pkgsrc::settings['home']],
    refreshonly => true,
 }~>
 exec { "${module_name}-update-pkgsrc_db":
    path        => ['/opt/local/sbin','/opt/local/bin'],
    command     => "pkgin -y up",
    require     => File[$pkgsrc::settings['home']],
    refreshonly => true,
 }
}
