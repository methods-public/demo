name 'rundeck-wrapper'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install and configure rundeck server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/rundeck-wrapper'
issues_url 'https://gitlab.com/chef-platform/rundeck-wrapper/issues'
version '1.1.0'

chef_version '>= 12.19'

supports 'centos', '>= 7.3'

depends 'rundeck-server'
depends 'cluster-search', '>= 1.3.0'
