name 'patchman'
maintainer 'Christopher Coffey'
maintainer_email 'nomad@cybermerc.org'
license 'Apache 2.0'
description 'Linux OS patch management system'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.0'

supports 'ubuntu'
supports 'centos'
supports 'redhat'

depends 'yum'
depends 'apt'
