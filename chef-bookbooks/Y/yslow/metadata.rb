# Encoding: utf-8

name             'yslow'
maintainer       'Benedict Dodd'
maintainer_email 'benedict.dodd@gmail.com'
license          'All rights reserved'
description      'Installs/Configures yslow'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'ubuntu',    '>= 10.04'
supports 'centos',    '>= 5.9'

depends 'phantomjs',  '~> 1.0.3'
