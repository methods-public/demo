name 'ugid-management'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Library cookbook to manage user and group ids'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/ugid-management'
issues_url 'https://gitlab.com/chef-platform/ugid-management/issues'
version '1.5.0'

chef_version '>= 12.14'

supports 'centos', '>= 7.1'

depends 'users'
