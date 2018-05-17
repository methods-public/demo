name             'twindb-repo'
maintainer       'Ovais Tariq'
maintainer_email 'ovaistariq@twindb.com'
license          'Apache v2.0'
description      'Installs/Configures twindb-repo'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

recipe "twindb-repo",       "Sets up the TwinDB package repository"

depends "packagecloud"

supports "centos", ">= 6.1"
supports "redhat", ">= 6.1"
supports "debian", ">= 7.4"
supports "ubuntu", ">= 12.04"
supports "amazon", ">= 2014.03"
