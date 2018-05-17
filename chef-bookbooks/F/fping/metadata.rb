name             'fping'

maintainer       'David Radcliffe'
maintainer_email 'radcliffe.david@gmail.com'
license          'MIT'
description      'Installs fping'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

recipe 'fping', 'Installs fping utility'

depends 'yum-repoforge'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'