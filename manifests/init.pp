class ferm inherits ferm::params {

	package {
		ferm: ensure => installed;
	}

	file {
		"${ferm_dir}/rules.d":
			ensure => directory,
			purge   => true,
			force   => true,
			recurse => true,
			notify  => Service['ferm'],
			require => Package["ferm"];
		"${ferm_dir}/macros.d":
			ensure => directory,
			purge   => true,
			force   => true,
			recurse => true,
			notify  => Service['ferm'],
			require => Package["ferm"];
		"$ferm_dir":
			ensure  => directory,
			mode    => '0755';
		"${ferm_dir}/conf.d":
			ensure  => directory,
			require => Package["ferm"];
		"$ferm_config":
			content => template('ferm/ferm.conf.erb'),
			require => Package["ferm"],
			mode    => '0400',
			notify  => Service['ferm'];
		"${ferm_dir}/conf.d/defs.conf":
			content => template("ferm/defs.conf.erb"),
			require => Package["ferm"],
			mode    => '0400',
			notify  => Service['ferm'];
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
