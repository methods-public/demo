name             'letsencrypt-boulder-server'
maintainer       'Thijs Houtenbos'
maintainer_email 'thoutenbos@schubergphilis.com'
license          'All rights reserved'
description      "Installs/Configures Boulder, the ACME-based CA server by Let's Encrypt."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url       'https://github.com/patcon/chef-letsencrypt-boulder-server/issues'
source_url       'https://github.com/patcon/chef-letsencrypt-boulder-server'
version          '0.1.2'

supports         'ubuntu', '= 14.04'
supports         'centos', '~> 7.0'

depends          'golang'
depends          'rabbitmq'
depends          'mariadb'
depends          'build-essential'
depends          'yum'
depends          'hostsfile'
