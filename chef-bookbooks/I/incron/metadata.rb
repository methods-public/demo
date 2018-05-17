name             'incron'
maintainer       'David Radcliffe'
maintainer_email 'radcliffe.david@gmail.com'
license          'MIT'
description      'Installs and configures incron'
version          '0.3.5'

recipe 'incron',  'Install incron package and starts the service'

depends 'yum'
depends 'yum-repoforge'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'oracle'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'