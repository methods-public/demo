name 'node_build'
maintainer 'Alvaro Faundez'
maintainer_email 'alvaro@faundez.net'
license 'MIT'
description 'Installs/Configures node-build'
long_description 'Installs/Configures node-build'
version '1.0.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

issues_url 'https://github.com/afaundez/node-build-cookbook/issues'
source_url 'https://github.com/afaundez/node-build-cookbook'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'freebsd'
supports 'opensuseleap'
supports 'ubuntu'

depends 'git', '~> 8.0.0'
