name 'dynamic-attributes'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Interprets and Rewrites Node Attributes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/dynamic-attributes'
issues_url 'https://gitlab.com/chef-platform/dynamic-attributes/issues'

version '1.1.0'

chef_version '>= 12.0'

# Should support anything as it is pure ruby
supports 'redhat'
supports 'centos'
supports 'scientific'
supports 'fedora'
supports 'debian'
supports 'ubuntu'
supports 'suse'
