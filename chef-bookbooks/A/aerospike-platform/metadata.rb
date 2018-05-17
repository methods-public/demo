name 'aerospike-platform'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install/Configure an aerospike cluster'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/aerospike-platform'
issues_url 'https://gitlab.com/chef-platform/aerospike-platform/issues'
version '1.1.0'

supports 'centos', '>= 7.3'

chef_version '>= 12.19'

depends 'ark'
depends 'cluster-search'
