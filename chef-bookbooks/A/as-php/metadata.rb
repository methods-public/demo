name             'as-php'
maintainer       'pingdecopong'
maintainer_email 'pingdecopong@gmail.com'
source_url       'https://github.com/pingdecopong/as-php'
license          'MIT'
description      'Installs/Configures as-php'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.3'

depends 'yum-epel'
depends 'yum-remi'

supports 'centos'
