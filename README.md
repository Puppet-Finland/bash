# Bash

A Puppet module for managing bash. Currently installation and removal of Bash 
and per-user .bashrc configurations are supported.

# Module usage

* [Class: bash](manifests/init.pp)
* [Define: bash::config::user](manifests/config/user.pp)

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* Debian 8
* Ubuntu 14.04

Any UNIX-style operating system should work out of the box or with minor 
modifications. For details see [params.pp](manifests/params.pp).

Note that operating systems which don't create per-user groups will not work out 
of the box if per-user .bashrc configurations are used. This is because owning 
group for files is assumed to be the same as the owning user.
