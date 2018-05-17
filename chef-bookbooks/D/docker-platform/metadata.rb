name 'docker-platform'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Use Docker ressources to install/configure Docker with attributes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/docker-platform'
issues_url 'https://gitlab.com/chef-platform/docker-platform/issues'
version '1.4.0'

chef_version '>= 12.14'

supports 'centos', '>= 7.1'

depends 'cluster-search'
depends 'docker'
