name 'journalbeat'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install and configure journalbeat daemon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/journalbeat'
issues_url 'https://gitlab.com/chef-platform/journalbeat/issues'
version '1.0.0'

chef_version '>= 12.19'

supports 'centos', '>= 7.3'
