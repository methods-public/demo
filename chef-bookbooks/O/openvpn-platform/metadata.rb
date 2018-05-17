name 'openvpn-platform'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install and configure openvpn server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/openvpn-platform'
issues_url 'https://gitlab.com/chef-platform/openvpn-platform/issues'
version '1.0.0'

supports 'centos', '>= 7.3'

depends 'yum-epel', '>= 2.1.2'

chef_version '>= 12.19'
