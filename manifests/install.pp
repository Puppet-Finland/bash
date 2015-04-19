# == Class: bash::install
#
# This class installs or removes Bash
#
class bash::install
(
    $ensure

) inherits bash::params
{
    package { $::bash::params::package_name:
        ensure => $ensure,
    }
}
