name 'custom-kernel'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install a custom linux kernel and reboot afterward'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/chef-platform/custom-kernel'
issues_url 'https://gitlab.com/chef-platform/custom-kernel/issues'
version '1.0.0'

chef_version '>= 12.19'

supports 'centos', '>= 7.3'
