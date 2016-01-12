 define ferm::rule
 (
	$host = false,
	$table="filter",
	$chain="INPUT",
	$rules,
	$description="",
	$domain = "ip",
	$prio="00",
	$notarule=false
 ) 
 {
	file { "/etc/ferm/rules.d/${prio}_${name}":
		ensure  => present,
		owner   => 'root',
		group   => 'root',
		mode    => '0400',
		content => template("ferm/ferm-rule.erb"),
		notify  => Exec["refresh_ferm"];
	}
}
