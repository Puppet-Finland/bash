#
# == Define: bash::config::user
#
# Configure Bash for a user. In practice a single include line is added to the 
# user's .bashrc file, which then loads .bashrc fragments from $HOME/.bashrc.d. 
# To keep things simple and manageable (with Hiera in particular) this define 
# only installs one fragment from the Puppet fileserver. The fragment must be 
# named as "username.bashrc".
#
# == Parameters
#
# [*title*]
#   The resource title defines the system user for whom Bash is configured. It 
#   also sets the filename of the .bashrc fragment on Puppet fileserver 
#   ($title.bashrc) and on the target system (puppet-$title.bashrc).
# [*ensure*]
#   Status of this user configuration. This parameter needs to be defined if 
#   using Hiera or catalog complation will fail. This is because Hiera / 
#   create_resources function can't handle empty hashes which have only a 
#   $title.
#
define bash::config::user
(
    $ensure = 'present'
)
{
    $username = $title

    # Root's home directory is not under /home
    $basedir = $username ? {
        'root'  => '/root',
        default => "${::os::params::home}/${username}"
    }

    $fragmentdir = "${basedir}/.bashrc.d"
    $fragmentfile = "${fragmentdir}/puppet-${username}.bashrc"

    # Make sure the .bashrc fragments are loaded from the main .bashrc file
    # which is, for the most part, not managed by Puppet.
    file_line { "bash-${basedir}-.bashrc-fragment-loader-line":
        ensure => $ensure,
        path   => "${basedir}/.bashrc",
        line   => '. ~/.bashrc.d/*.bashrc',
    }

    $fragmentdir_ensure = $ensure ? {
        'present' => directory,
        'absent'  => undef,
    }

    # Create the $HOME/.bashrc.d (fragment) directory. If $ensure == 'absent', 
    # we just unmanage the directory, so that a recursive deletion does not 
    # wreak any havoc by mistake.
    file { "bash-${fragmentdir}":
        ensure => $fragmentdir_ensure,
        name   => $fragmentdir,
        owner  => $username,
        group  => $username,
        mode   => '0750',
    }

    # Add the user-specific .bashrc fragment. Currently only one static per-user 
    # file is supported.
    file { "bash-${fragmentfile}":
        ensure  => $ensure,
        name    => $fragmentfile,
        source  => "puppet:///files/${username}.bashrc",
        owner   => $username,
        group   => $username,
        mode    => '0750',
        require => File["bash-${fragmentdir}"],
    }
}
