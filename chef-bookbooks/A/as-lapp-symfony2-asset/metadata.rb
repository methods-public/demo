name             'as-lapp-symfony2-asset'
maintainer       'pingdecopong'
maintainer_email 'pingdecopong@gmail.com'
source_url       'https://github.com/pingdecopong/as-lapp-symfony2-asset'
license          'MIT'
description      'Installs/Configures as-lapp-symfony2-asset'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.2'

depends 'as-apache2'
depends 'as-php'
depends 'as-postgresql'
depends 'as-symfony2'
depends 'as-asset'

supports 'centos'
