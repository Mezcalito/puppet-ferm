 define ferm::macro
 (
	$macro,
	$description="",
    $prio="00"
 ) 
 {
	file { "/etc/ferm/macros.d/${prio}_${name}":
		ensure  => present,
		owner   => root,
		group   => root,
		mode    => '0400',
		content => template("ferm/ferm-macro.erb"),
		notify  => Exec["refresh_ferm"];
	}
}
