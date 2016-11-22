 define ferm::macro
 (
	$macro,
	$description="",
    $prio="00"
 ) 
 {
	file { "${ferm::ferm_dir}/macros.d/${prio}_${name}":
		ensure  => present,
		owner   => root,
		group   => root,
		mode    => '0400',
		content => template("ferm/ferm-macro.erb"),
		notify  => Service['ferm'];
	}
}
