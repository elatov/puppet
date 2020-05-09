# == Class ohmyzsh::install
#
# This class is called from ohmyzsh for install.
#
class ohmyzsh::install {

  ensure_resource ('user',$ohmyzsh::settings['user'],{ 'ensure'=> 'present' })

  ensure_resource ('file',
                   $ohmyzsh::user_home_dir,
                   {'ensure' => 'directory',})

  ensure_packages($ohmyzsh::settings['pre_pkgs'],{ 'ensure'=> 'present' })

  vcsrepo { "${ohmyzsh::user_home_dir}/.oh-my-zsh" :
    ensure   => present,
    provider => git,
    source   => $ohmyzsh::settings['repo_url'],
  }

  if ($ohmyzsh::settings['install_percol']){
    case $::osfamily {
      'Debian': {
        ensure_packages(['python3-pip'],{ 'ensure'=> 'present' })
        ensure_packages(['percol'], {
          ensure   => present,
          provider => 'pip3',
          require  => [ Package['python3-pip'], ],
        })
      }
      'RedHat': {
        ensure_packages(['python2-pip'],{ 'ensure'=> 'present' })
        ensure_packages(['percol'], {
          ensure   => present,
          provider => 'pip',
          require  => [ Package['python2-pip'], ],
        })
      }
      'FreeBSD': {
        ensure_packages(['py27-pip'],{ 'ensure'=> 'present' })
        ensure_packages(['percol'], {
          ensure   => present,
          provider => 'pip',
          require  => [ Package['py27-pip'], ],
        })
      }
      'Solaris': {
        ensure_packages(['percol'], {
          ensure   => present,
          provider => 'pip',
        })
      }
    }
  }

}
