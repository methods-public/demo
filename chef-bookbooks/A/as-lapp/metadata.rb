name             'as-lapp'
maintainer       'pingdecopong'
maintainer_email 'pingdecopong@gmail.com'
source_url       'https://github.com/pingdecopong/as-lapp'
license          'MIT'
description      'Installs/Configures as-lapp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.3'

depends 'as-apache2'
depends 'as-php'
depends 'as-postgresql'

supports 'centos'
