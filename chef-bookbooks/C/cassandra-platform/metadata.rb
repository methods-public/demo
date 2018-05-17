name 'cassandra-platform'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install and Configure Apache Cassandra'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/cassandra-platform'
issues_url 'https://gitlab.com/chef-platform/cassandra-platform/issues'
version '2.3.0'

chef_version '>= 12.14'

depends 'cluster-search'
depends 'ark'

supports 'centos', '>= 7.1'
