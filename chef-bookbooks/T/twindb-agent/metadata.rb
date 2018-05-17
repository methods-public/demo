name             'twindb-agent'
maintainer       'Ovais Tariq'
maintainer_email 'ovaistariq@twindb.com'
license          'Apache v2.0'
description      'Installs/Configures twindb-agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.0'

recipe "twindb-agent",              "Installs and configures TwinDB agent"
recipe "twindb-agent::register",    "Register the MySQL instance with TwinDB server"
recipe "twindb-agent::unregister",  "Unregister the MySQL instance with TwinDB server"

depends "twindb-repo"

supports "centos", ">= 6.1"
supports "redhat", ">= 6.1"
supports "debian", ">= 7.4"
supports "ubuntu", ">= 12.04"
supports "amazon", ">= 2014.03"
