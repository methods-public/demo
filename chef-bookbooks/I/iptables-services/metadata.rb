name 'iptables-services'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install/Configure iptables-services on linux nodes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/iptables-services'
issues_url 'https://gitlab.com/chef-platform/iptables-services/issues'
version '2.2.0'

chef_version '>= 12.14'

supports 'centos', '>= 7.3'

depends 'cluster-search'
