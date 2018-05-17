name 'bind-ddns'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install and configure ISC Bind on server and nsupdate on clients'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/bind-ddns'
issues_url 'https://gitlab.com/chef-platform/bind-ddns/issues'
version '1.13.0'

chef_version '>= 12.0'

supports 'centos', '>= 7.1'
