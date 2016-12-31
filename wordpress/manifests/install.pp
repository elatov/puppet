# == Class wordpress::install
#
# This class is called from wordpress for install.
#
class wordpress::install {

  wordpress::instance { '${wordpress::install_dir}':
    install_dir           => '${wordpress::install_dir}',
    download_url          => '${wordpress::download_url}',
    version               => '${wordpress::version}',
    wp_owner              => '${wordpress::wp_owner}',
    wp_group              => '${wordpress::wp_group}',
    settings              => '${wordpress::settings}'
  }
}
