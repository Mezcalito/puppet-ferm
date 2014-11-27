class ferm {

	package { 'ferm':
    ensure => installed,
	} ->
  service { 'ferm':
    ensure => running,
    enable => true,
  }

  file { "/etc/ferm/rules.d":
    ensure => directory,
    purge   => true,
    owner   => root,
    group   => root,
    force   => true,
    recurse => true,
    notify  => Service["ferm"],
    require => Package["ferm"],
  }

	file { "/etc/ferm/conf.d":
    ensure  => directory,
    owner   => root,
    group   => root,
    require => Package["ferm"],
  }

	file {	"/etc/default/ferm":
    source  => "puppet:///modules/ferm/ferm.default",
    owner   => root,
    group   => root,
    require => Package["ferm"],
    notify  => Service["ferm"],
  }

	file { "/etc/ferm/ferm.conf":
    source  => "puppet:///modules/ferm/ferm.conf",
    owner   => root,
    group   => root,
    mode    => 0400,
    require => Package["ferm"],
    notify  => Serivce["ferm"];
	}

}