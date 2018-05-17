name             'virtualbox-guest-additions'
maintainer       'Patrick Ayoup'
maintainer_email 'patrick.ayoup@gmail.com'
license          'MIT'
description      'Installs/Configures virtualbox-guest-additions'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
supports 'centos', '= 6.5'
version          '0.1.0'

depends 'yum-epel', '~> 0.4.0'
