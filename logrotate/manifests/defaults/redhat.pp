# Internal: Manage the default redhat logrotate rules.
#
# Examples
#
#   include logrotate::defaults::redhat
class logrotate::defaults::redhat {
  Logrotate::Rule {
    missingok    => true,
  }
}
