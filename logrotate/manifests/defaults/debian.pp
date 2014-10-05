# Internal: Manage the default debian logrotate rules.
#
# Examples
#
#   include logrotate::defaults::debian
class logrotate::defaults::debian {
  Logrotate::Rule {
    missingok    => true,
  }

}
