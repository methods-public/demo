name 'yum-hp'
maintainer  'Nerijus Bendziunas'
maintainer_email 'nerijus.bendziunas@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures HP Service Pack for ProLiant YUM repository'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
depends 'yum', '~> 3.2'
supports 'centos'

version '0.0.3'
