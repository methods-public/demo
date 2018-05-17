name             'opt-modules'
maintainer       'Indiana University'
maintainer_email 'kj.tanaka@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures Environment Modules'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'
supports         'centos', "= 6.5"
supports         'ubuntu', "= 12.04"

depends 'build-essential'
depends 'apt'
