class ferm {

	package {
		ferm: ensure => installed;
	}

	file {
		"/etc/ferm/rules.d":
			ensure => directory,
			purge   => true,
			owner   => root,
			group   => root,
			force   => true,
			recurse => true,
			notify  => Service['ferm']
			require => Package["ferm"];
		"/etc/ferm/macros.d":
			ensure => directory,
			purge   => true,
			owner   => root,
			group   => root,
			force   => true,
			recurse => true,
			notify  => Service['ferm']
			require => Package["ferm"];
		"/etc/ferm":
			ensure  => directory,
			owner   => root,
			group   => root,
			mode    => '0755';
		"/etc/ferm/conf.d":
			ensure  => directory,
			owner   => root,
			group   => root,
			require => Package["ferm"];
		"/etc/default/ferm":
			source  => "puppet:///modules/ferm/ferm.default",
			owner   => root,
			group   => root,
			require => Package["ferm"],
			notify  => Service['ferm']
		"/etc/ferm/ferm.conf":
			source => [
			"puppet:///modules/site_ferm/${::fqdn}/ferm.conf",
			"puppet:///modules/site_ferm/${::operatingsystem}/ferm.conf",
			"puppet:///modules/site_ferm/ferm.conf",
			"puppet:///modules/ferm/${::operatingsystem}/ferm.conf",
			"puppet:///modules/ferm/ferm.conf"
			],
			owner   => root,
			group   => root,
			require => Package["ferm"],
			mode    => '0400',
			notify  => Service['ferm']
		"/etc/ferm/conf.d/defs.conf":
			content => template("ferm/defs.conf.erb"),
			owner   => root,
			group   => root,
			require => Package["ferm"],
			mode    => '0400',
			notify  => Service['ferm']
		}
    
    service { 'ferm':
        ensure      => 'running',
        enable      => true,
        hasrestart  => true,
        hasstatus   => false,
        require     => Package['ferm']
    }
}
# vim:set et:
# vim:set sts=4 ts=4:
# vim:set shiftwidth=4:
