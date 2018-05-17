name 'consul-platform'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install and Configure a Consul cluster'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/consul-platform'
issues_url 'https://gitlab.com/chef-platform/consul-platform/issues'
version '1.1.0'

chef_version '>= 12.14'

supports 'centos', '>= 7.1'

depends 'cluster-search'
depends 'ark'
