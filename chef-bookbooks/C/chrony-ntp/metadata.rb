name 'chrony-ntp'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install and configure chrony daemon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/chrony-ntp'
issues_url 'https://gitlab.com/chef-platform/chrony-ntp/issues'
version '1.2.0'

supports 'centos', '>= 7.3'
supports 'debian', '>= 8.0'

chef_version '>= 12.19'
