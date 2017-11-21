# == Class ohmyzsh::params
#
# This class is meant to be called from ohmyzsh.
# It sets variables according to platform.
#
class ohmyzsh::params {
  $settings_all	 =	{
                      'user' 	          => 'test',
                      'repo_url'        => 'https://github.com/robbyrussell/oh-my-zsh.git',
                      'install_theme'   => 'rkj-repos.zsh-theme',
                      'pre_pkgs'        => [ 'git',
                                             'zsh'
                                          ],
                      'install_percol'  => true
                    }
  case $::osfamily {
    'Debian': {
      case $::operatingsystem {
        'ubuntu': {
          $settings_os  = {}
        }
        'debian': {
          $settings_os  = {}
        }
      }
    }
    'RedHat' : {
      $settings_os  = {}
    }
    'FreeBSD': {
      $settings_os  = {}
    }
    'Solaris': {
      $settings_os  = {}
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
  $default_settings = merge($settings_all,$settings_os)
}
