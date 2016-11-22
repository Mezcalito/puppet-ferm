class ferm::params {

    $ferm_dir = '/etc/ferm'
    case $::osfamily {
        'Debian':  {
            $ferm_config = '/etc/ferm/ferm.conf'
        }
        'RedHat':  {
            $ferm_config = '/etc/ferm.conf'
        }
        'Archlinux':  {
            $ferm_config = '/etc/ferm.conf'
        }
        default:   {
        }
    }
}
