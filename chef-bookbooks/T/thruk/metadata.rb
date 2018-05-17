name             'thruk'
maintainer       'Martha Greenberg'
maintainer_email 'marthag@mit.edu'
license          'Apache 2.0'
description      'Installs/Configures thruk'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.0'

depends 'yum'
depends 'yum-epel'
depends 'apache2'
depends 'apt'

# needed for test-kitchen only
recommends 'curl'

supports 'centos'
supports 'debian'
supports 'ubuntu'
