name 'storm-platform'
maintainer 'Sam4Mobile'
maintainer_email 'dps.team@s4m.io'
license 'Apache 2.0'
description 'Install/Configure a Storm cluster'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/s4m-chef-repositories/storm-platform'
issues_url 'https://gitlab.com/s4m-chef-repositories/storm-platform/issues'
version '2.0.0'

supports 'centos', '>= 7.1'

depends 'ark'
depends 'cluster-search'
