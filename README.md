# Bash

A Puppet module for managing bash. Currently installation and removal of Bash 
and per-user .bashrc configurations are supported.

# Module usage

Ensure Bash is installed:

    include ::bash

Install a bashrc configuration fragment from Puppet fileserver for a particular
user:

    include ::bash
    
    # Installs puppet-joe.bashrc from the "files" share on the Puppet Fileserver
    ::bash::config::user { 'joe': }

Note that operating systems which don't create per-user groups will not work out 
of the box if per-user .bashrc configurations are used. This is because owning 
group for files is assumed to be the same as the owning user.
