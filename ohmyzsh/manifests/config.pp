# == Class ohmyzsh::config
#
# This class is called from ohmyzsh for service config.
#
class ohmyzsh::config {
  ## Get the User's Home Directory
  $var  = "home_${settings['user']}"
  $user_home_dir = inline_template("<%= scope.lookupvar('::$var') %>")

}
