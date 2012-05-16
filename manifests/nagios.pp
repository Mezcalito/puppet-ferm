 
define ferm::nagios($nagios_host=false, $table="filter", $chain="INPUT", $rules, $prio="00") {
	file {
		"/etc/ferm/rules.d/${prio}_nagios":
			ensure  => present,
			owner   => root,
			group   => root,
			mode    => 0400,
			content => template("ferm/nagios.erb"),
			notify  => Service["ferm"];
	}
}