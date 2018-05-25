# ferm

#### Table of Contents

1. [Description](#description)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)

## Description

This puppet module manages ferm and its rules.

## Usage

`include ferm`

ferm::rules
----------

Add a rule to the ferm rules.d directory:

`  ferm::rule { 'allow_http':
    rules       => ['proto tcp dport 80 ACCEPT'],
    host        => 'test3',
    interface   => 'eth1',
    daddr       => '10.255.1.10',
    table       => 'filter',
    chain       => 'INPUT',
    description => 'Allow protocole http',
    prio        => '00',
    notarule    => false,
}`

ferm::hook
----------
Add a hook to the ferm conf.d directory.

`ferm::hook { 'conntrack_ftp':
  description => 'Module nf_conntrack_ftp pour proftpd',
  content_hook => 'modprobe nf_conntrack_ftp'
}`

rule defined resource

	This creates an entry in the correct chain file for ferm.

[*chain*]

	The name of the chain

[*policy*]

	The desired policy. Allowed values are Enum['ACCEPT','DROP', 'REJECT']

[*dport*]

	The destination port we want to filter for. Can be any string from /etc/services or an integer

[*saddr or host*]

	Source IPv4/IPv6 address. Can be one or many of them. Multiple addresses are always encapsulated in braces: '(127.0.0.1 2003::)'

	IPv4 and IPv6 addresses can be mixed. CIDR notation is possible if you want to block networks, otherwise /32 or /128 is assumed by ferm/ip(6)tables

[*daddr*]

	Same as above, just for the destination IP address.

## Reference

### Classes

`ferm` The ferm class performs all steps needed to the use of ferm such as package installation and configuration. Specific rules can be added later with ferm::rule or specific classes.

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
