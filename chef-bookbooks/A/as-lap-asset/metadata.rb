name             'as-lap-asset'
maintainer       'pingdecopong'
maintainer_email 'pingdecopong@gmail.com'
source_url       'https://github.com/pingdecopong/as-lap-asset'
license          'MIT'
description      'Installs/Configures as-lap-asset'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

depends 'as-apache2'
depends 'as-php'
depends 'as-asset'

supports 'centos'
