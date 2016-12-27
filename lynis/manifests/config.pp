# == Class lynis::config
#
# This class is called from lynis for service config.
#
class lynis::config {
  if ( $::lynis::settings['cron_enabled'] == true ){
    ensure_packages('crontabs',{ensure => 'present'})

     file {'/etc/cron.weekly/lynis':
      ensure  => 'present',
      content => template('lynis/lynis-cron.erb'),
      mode    => '0755',
      require => Package['crontabs'],
      links   => 'follow',
    }
  }
}
