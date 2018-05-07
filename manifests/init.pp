# == Class: bash
#
# This class sets up bash and optionally adds some user-specific .bashrc 
# configurations.
#
# == Parameters
#
# [*manage*]
#   Whether to manage bash using Puppet. Valid values true (default) and 
#   false.
# [*ensure*]
#   Status of bash. Valid values 'present' (default) and 'absent'.
# [*userconfigs*]
#   A hash of bash::config::user resources to realize.
#
# == Examples
#
# An example for Hiera:
#
#   ---
#   classes:
#       - bash
#   
#   bash::ensure: 'present'
#   bash::userconfigs:
#       samuli:
#           ensure: 'present'
#
# The configuration file for user 'samuli' would have to be on the Puppet 
# fileserver and have the name 'samuli.bashrc'.
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class bash
(
    Boolean                  $manage = true,
    Enum['present','absent'] $ensure = 'present',
    Hash                     $userconfigs = {}

) inherits bash::params
{

if $manage {

    class { '::bash::install':
        ensure => $ensure,
    }

    class { '::bash::config':
        ensure      => $ensure,
        userconfigs => $userconfigs,
    }
}
}
