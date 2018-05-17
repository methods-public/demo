name             'dotnetcore'
maintainer       'Andrew Cornies'
maintainer_email 'acornies@gmail.com'
license          'All rights reserved'
description      'Installs/Configures dotnetcore'
long_description 'Installs/Configures dotnetcore'
version          '1.1.3'

depends 'apt'
depends 'tar'

supports 'ubuntu', '= 14.04'
supports 'ubuntu', '= 16.04'
supports 'centos', '>= 7.1'
supports 'oracle', '>= 7.1'
supports 'redhat', '>= 7.1'
supports 'amazon'
supports 'windows'

provides 'dotnetcore::default'

source_url 'https://github.com/acornies/dotnetcore-cookbook'
issues_url 'https://github.com/acornies/dotnetcore-cookbook/issues'

long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
license 'Apache v2.0'
