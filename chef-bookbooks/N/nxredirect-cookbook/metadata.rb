name 'nxredirect-cookbook'
maintainer 'Make.org'
maintainer_email 'sre@make.org'
license 'Apache-2.0'
description 'Install and Configure NXRedirect as a Systemd Service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
main_url = 'https://gitlab.com/chef-platform'
source_url "#{main_url}/nxredirect-cookbook"
issues_url "#{main_url}/nxredirect-cookbook/issues"
version '1.2.0'

chef_version '>= 12.9'

supports 'centos', '>= 7.1'
