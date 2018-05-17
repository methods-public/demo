name 'test-chrony-ntp'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache 2.0'
description 'Helper Cookbook to test Chrony'
long_description 'Helper Cookbook to test Chrony'
source_url 'https://gitlab.com/chef-platform/chrony-ntp'
issues_url 'https://gitlab.com/chef-platform/chrony-ntp/issues'
version '1.0.0'

chef_version '>= 12.19'

supports 'centos', '>= 7.3'
supports 'debian', '>= 8'

depends 'chrony-ntp'
