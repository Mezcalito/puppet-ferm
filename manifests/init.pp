class ferm (
  Boolean $default_allow_ssh = true,
  Boolean $cache = true,
  Boolean $fast = true,
){
  package { 'ferm':
    ensure => installed,
  }
  file { '/etc/ferm/rules.d':
    ensure  => directory,
    purge   => true,
    owner   => root,
    group   => root,
    force   => true,
    recurse => true,
    notify  => Exec['refresh_ferm'],
    require => Package['ferm'],
  }
  file { '/etc/ferm/rules-6.d':
    ensure  => directory,
    purge   => true,
    owner   => root,
    group   => root,
    force   => true,
    recurse => true,
    notify  => Exec['refresh_ferm'],
    require => Package['ferm'],
  }
  file { '/etc/ferm/conf.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    require => Package['ferm'],
  }
  file { '/etc/default/ferm':
    content => template('ferm/ferm.default.erb'),
    owner   => root,
    group   => root,
    require => Package['ferm'],
    notify  => Exec['refresh_ferm'],
  }
  file { '/etc/ferm/ferm.conf':
    content => template('ferm/ferm.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0400',
    require => Package['ferm'],
    notify  => Exec['refresh_ferm'],
  }
  exec { 'refresh_ferm':
    command     => '/etc/init.d/ferm restart',
    require     => Package['ferm'],
    refreshonly => true
  }
}
