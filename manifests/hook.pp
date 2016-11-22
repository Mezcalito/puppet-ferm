 define ferm::hook (
	$description=undef,
	$content_hook=undef
 ) 
 {
   
	file { "${ferm::ferm_dir}/conf.d/hook_${name}":
		ensure  => present,
		owner   => root,
		group   => root,
		mode    => '0400',
		content => template("ferm/hook.erb"),
		notify  => Service['ferm'];
	}
}
