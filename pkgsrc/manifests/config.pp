# == Class pkgsrc::config
#
# This class is called from pkgsrc
#
class pkgsrc::config {

  exec { "${module_name}-wget-pkgsrc":
    path    => ['bin','/usr/bin'],
    cwd     => '/root/apps',
    command => "wget http://${settings['url']}/bootstrap-${settings['version']}-x86_64.tar.gz",
    require => File['/root/apps'],
    unless  => "test -f /root/apps/bootstrap-${settings['version']}-x86_64.tar.gz",
  }~>
  exec { "${module_name}-extract-pkgsrc":
    path    => ['bin','/usr/bin'],
    cwd     => '/root/apps',
    command => "tar /root/apps/bootstrap-${settings['version']}-x86_64.tar.gz -C ${settings['home']} ",
    unless  => "test -f /root/apps/bootstrap-${settings['version']}-x86_64.tar.gz",
    refreshonly => true,
 }
}
