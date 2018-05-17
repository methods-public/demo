# Encoding: utf-8
name 'perforce'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Installs Perforce Command-Line Client (p4)'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://github.com/dhoer/chef-perforce'
issues_url 'https://github.com/dhoer/chef-perforce/issues'
version '2.2.0'

chef_version '>= 12.14'

supports 'centos', '>= 6.0'
supports 'redhat', '>= 6.0'
supports 'debian', '>= 7.0'
supports 'fedora', '>= 19.0'
supports 'ubuntu', '>= 12.04'
supports 'windows'
supports 'mac_os_x'
