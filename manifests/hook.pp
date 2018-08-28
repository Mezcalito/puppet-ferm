define ferm::hook(
  $description = undef,
  $content_hook = undef,
  $when_hook = 'pre',
) {

  file { "/etc/ferm/conf.d/hook_${name}":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0400',
    content => template('ferm/hook.erb'),
    notify  => Exec['refresh_ferm'],
  }

}
