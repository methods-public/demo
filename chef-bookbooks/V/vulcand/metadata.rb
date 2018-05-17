name             'vulcand'
maintainer       'Petr Belyaev'
maintainer_email 'upcfrost@gmail.com'
license          'All rights reserved'
description      'Installs/Configures vulcand'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
source_url       'https://github.com/upcFrost/chef_vulcand_cookbook'
issues_url       'https://github.com/upcFrost/chef_vulcand_cookbook/issues'

depends 'docker'
depends 'golang'

supports 'centos'
supports 'debian'
supports 'ubuntu'