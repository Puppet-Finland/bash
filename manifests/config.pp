#
# == Class: bash::config
#
# Configure Bash
#
class bash::config
(
    $ensure,
    $userconfigs

) inherits bash::params
{
    # Per-user configuration. No system-wide configuration support yet.
    create_resources('bash::config::user', $userconfigs)
}
