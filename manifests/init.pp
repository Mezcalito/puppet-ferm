class ferm (
  $default_allow_ssh = true,
  $cache = true,
  $fast = true,
){

	package { 'ferm':
    ensure => installed,
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
    content  => template("ferm/ferm.default.erb"),
    owner   => root,
    group   => root,
    require => Package["ferm"],
    notify  => Service["ferm"],
  }

	file { "/etc/ferm/ferm.conf":
    content  => template("ferm/ferm.conf.erb"),
    owner   => root,
    group   => root,
    mode    => 0400,
    require => Package["ferm"],
    notify  => Service["ferm"];
	}

  service { 'ferm':
    ensure => running,
    enable => true,
    require => Package["ferm"]
  }

}