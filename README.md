# ferm

#### Table of Contents

1. [Description](#description)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)

## Description

This puppet module manages ferm and its rules.

## Usage

``` puppet
class { 'ferm': }
```

ferm::rules
----------

To add a rule to the ferm rules.d directory:

``` puppet
  ferm::rule { 'allow_http':
    rules       => ['proto tcp dport 80 ACCEPT'],
    host        => 'test3',
    interface   => 'eth1',
    daddr       => '10.255.1.10',
    table       => 'filter',
    chain       => 'INPUT',
    description => 'Allow protocole http',
    prio        => '00',
    notarule    => false,
}
```

ferm::hook
----------
To add a hook to the ferm conf.d directory.

```puppet
ferm::hook { 'conntrack_ftp':
  description => 'Module nf_conntrack_ftp pour proftpd',
  content_hook => 'modprobe nf_conntrack_ftp'
}
```

## Reference

### Class: `ferm`

`ferm` The ferm class performs all steps needed to the use of ferm such as package installation and configuration. Specific rules can be added later with ferm::rule or specific classes.

**Parameters within `ferm`**:

#### `default_allow_ssh`

Allow SSH connections.

#### `cache`

Cache the output of ferm --lines in /var/cache/ferm?

#### `fast`

Enable fast mode: ferm generates an iptables-save(8) file, and installs it with iptables-restore(8). This is much faster, because ferm calls iptables(8) once for every rule by default.
Fast mode is enabled by default since ferm 2.0, deprecating this option.

### Defined type: `ferm::rule`

This creates an entry in the correct chain file for ferm.

#### `host or saddr`

Source IPv4/IPv6 address. Can be one or many of them. Multiple addresses are always encapsulated in braces: '(127.0.0.1 2003::)'
IPv4 and IPv6 addresses can be mixed. CIDR notation is possible if you want to block networks, otherwise /32 or /128 is assumed by ferm/ip(6)tables

#### `interface`

Define the interface name, your outside network card, like eth0, or dialup like ppp1, or whatever device you want to match for passing packets. It is equivalent to the -i switch in iptables(8).

#### `daddr`

Same as above, just for the destination IP address.

#### `table [filter|nat|mangle]`

Specifies which netfilter table this rule will be inserted to: "filter" (default), "nat" or "mangle".

#### `chain`

Specifies the netfilter chain (within the current table) this rule will be inserted to. Common predefined chain names are "INPUT", "OUTPUT", "FORWARD","PREROUTING", "POSTROUTING", depending on the table. See the netfilter documentation for details. If you specify a non-existing chain here, ferm will add the rule to a custom chain with that name.

#### `description`

The description of the rule.

#### `prio`

Priority of the rule. Default: '00'.

## Limitations
ferm can be installed and used on:

* Debian Jessie
* Debian Stretch

Licensing
=========

This puppet module is licensed under the GPL version 3 or later. Redistribution
and modification is encouraged.

The GPL version 3 license text can be found in the "LICENSE" file accompanying
this puppet module, or at the following URL:

http://www.gnu.org/licenses/gpl-3.0.html
