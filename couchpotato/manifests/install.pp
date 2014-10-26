class couchpotato::install {
  
  ### install the prereq packages
  $prereq_pkgs = ["git","python"]
  
  ensure_resource('package', $prereq_pkgs, {'ensure' => 'present'})
  
  if ! defined (User[$couchpotato::user]) {
    user {$couchpotato::user:
      ensure => "present",
    }
  }
  
	# Clone the couchpotato source using vcsrepo
	# depends on the vcsrepo module
  vcsrepo { $couchpotato::install_dir:
    ensure   => "present",
    provider => "git",
    source   => 'git://github.com/RuudBurger/CouchPotatoServer.git',
    owner    => $couchpotato::user,
    require  => User[$couchpotato::user],
  }
}