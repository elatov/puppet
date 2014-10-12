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
  $user           = $update_checker::params::update_checker_user,
  $update_script  = $update_checker::params::update_checker_script,
  $packages       = $update_checker::params::update_checker_packages,
  $cron_dir       = $update_checker::params::update_checker_cron_dir,
) inherits update_checker::params {
  
  validate_string($update_script)
  
  class { 'update_checker::install': }->
  class { 'update_checker::config': } ->
  Class['update_checker']
}
