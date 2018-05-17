name 'kea-dhcp'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install and Configure ISC Kea DHCP server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/kea-dhcp'
issues_url 'https://gitlab.com/chef-platform/kea-dhcp/issues'
version '1.1.0'

chef_version '>= 12.14'

supports 'centos', '>= 7.3'

depends 'network_interfaces_v2'
