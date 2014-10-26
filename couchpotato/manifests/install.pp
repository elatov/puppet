class couchpotato::install {
  
  if ($couchpotato::settings['pkgs_pre'] != undef){
    ensure_resource('package', $couchpotato::settings['pkgs_pre'], {'ensure' => 'present'})
  }
  
  if ($couchpotato::settings['user'] != undef){
    ensure_resource('user', $couchpotato::settings['user'], {'ensure' => 'present'})
  }
  
	# Clone the couchpotato source using vcsrepo
	# depends on the vcsrepo module
  vcsrepo { $couchpotato::install_dir:
    ensure   => 'present',
    provider => 'git',
    source   => 'git://github.com/RuudBurger/CouchPotatoServer.git',
    owner    => $couchpotato::settings['user'],
    require  => [User[$couchpotato::settings['user']],Package[$couchpotato::settings['pkgs_pre']]],
  }
}