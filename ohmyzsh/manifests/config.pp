# == Class ohmyzsh::config
#
# This class is called from ohmyzsh for service config.
#
class ohmyzsh::config {

  if ($ohmyzsh::settings['install_theme']){
    ensure_resource ( 'file',
                      "${ohmyzsh::user_home_dir}/.oh-my-zsh/custom/themes/",
                      {'ensure' => 'directory',}
                    )
    exec { "ohmyzsh copy theme for ${ohmyzsh::settings['user']}":
      path  => ['/bin','/usr/bin/'],
      onlyif  => "test -d ${ohmyzsh::user_home_dir}/
      .oh-my-zsh/custom/themes/${ohmyzsh::settings['install_theme']}",
      command => "cp -rp ${ohmyzsh::user_home_dir}/
      .oh-my-zsh/themes/${ohmyzsh::settings['install_theme']} ${ohmyzsh::user_home_dir}/
      .oh-my-zsh/custom/themes/${ohmyzsh::settings['install_theme']}",
      require => Vcsrepo["${ohmyzsh::user_home_dir}/.oh-my-zsh"]
    }
  }

  file {"${ohmyzsh::user_home_dir}/.zshrc":
    ensure  => "link",
    target  => "${ohmyzsh::user_home_dir}/.gdrive/notes/.zshrc",
    require => [Class['drive']],
  }

  file {"${ohmyzsh::user_home_dir}/.zsh_aliases":
    ensure  => "link",
    target  => "${ohmyzsh::user_home_dir}/.gdrive/notes/.zsh_aliases",
    require => [Class['drive']],
  }

}
