name 'ovh-api'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Configure and control your servers on OVH by its API'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/ovh-api'
issues_url 'https://gitlab.com/chef-platform/ovh-api/issues'
version '2.3.0'

chef_version '>= 12.14'

supports 'centos'
supports 'debian'
supports 'ubuntu'

depends 'ohai', '>= 4.0'
