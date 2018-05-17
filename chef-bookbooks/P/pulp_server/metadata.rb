name 'pulp_server'
maintainer 'Liudas Baksys'
maintainer_email 'liudasbk@users.noreply.github.com'
license 'MIT'
description 'Installs/Configures pulp_server'
long_description 'Installs/Configures pulp_server'
version '0.2.1'
chef_version '>= 12.1' if respond_to?(:chef_version)
issues_url 'https://github.com/liudasbk/pulp-server-cookbook/issues'
source_url 'https://github.com/liudasbk/pulp-server-cookbook'
supports 'centos'
supports 'redhat'
gem 'httpclient'