name 'galera-platform'
maintainer 'Sam4Mobile'
maintainer_email 'dps.team@s4m.io'
license 'Apache 2.0'
description 'Install and configure a Galera Cluster'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/s4m-chef-repositories/galera-platform'
issues_url 'https://gitlab.com/s4m-chef-repositories/galera-platform'
version '2.0.0'

supports 'centos', '>= 7.1'
depends 'cluster-search'
depends 'yum'
