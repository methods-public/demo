name             'ratpoison'
maintainer       'Miguel Ferreira'
maintainer_email 'mferreira@schubergphilis.com'
license          'Apache License, Version 2.0'
description      'Installs/Configures ratpoison window manager'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.0'

supports         'centos'

depends          'yum-epel', '>= 0.3.6'
depends          'xvfb',     '>= 2.0.0'
