#
# == Class: bash::params
#
# Defines some variables based on the operating system
#
class bash::params {

    include ::os::params

    case $::osfamily {
        'RedHat': {
            $package_name = 'bash'
        }
        'Debian': {
            $package_name = 'bash'
        }
        'FreeBSD': {
            $package_name = 'bash'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
