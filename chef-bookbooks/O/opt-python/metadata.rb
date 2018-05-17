name             'opt-python'
maintainer       'FutureSystems, Indiana University'
maintainer_email 'kj.tanaka@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures python as an optional software package'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'
supports         'centos', "= 6.5"

depends 'build-essential'
