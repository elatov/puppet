# Class: update_checker
#
# This module manages update_checker
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class update_checker(
  $update_script  = $update_checker::params::update_checker_script,
  $packages       = $update_checker::params::update_checker_packages,
  $cron_dir       = $update_checker::params::update_checker_cron_dir,
  $target_dir     = $update_checker::params::update_checker_target_dir,
  $user           = $update_checker::params::update_checker_user,
  $test           = $update_checker::params::update_checker_test,
) inherits update_checker::params {
  
  validate_string($update_script)
  
  class { 'update_checker::install': }->
  class { 'update_checker::config': } ->
  Class['update_checker']
}
