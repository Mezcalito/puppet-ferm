define ferm::rule(
  Array[String] $rules,
  Optional[String] $host = undef,
  Optional[String] $interface = undef,
  Optional[String] $daddr = undef,
  Enum['ip', 'ip6'] $domain = 'ip',
  String $table = 'filter',
  String $chain = 'INPUT',
  String $description = '',
  String $prio = '00',
  Boolean $notarule = false,
) {
  if $domain == 'ip' {
    file { "/etc/ferm/rules.d/${prio}_${name}":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0400',
      content => template('ferm/ferm-rule.erb'),
      notify  => Exec['refresh_ferm'],
    }
  }
  elsif $domain == 'ip6' {
    file { "/etc/ferm/rules-6.d/${prio}_${name}":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0400',
      content => template('ferm/ferm-rule.erb'),
      notify  => Exec['refresh_ferm'],
    }
  }
}
