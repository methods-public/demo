name 'desalination'
maintainer 'Jon Middleton'
maintainer_email 'jjm@geeky-and-blonde.me.uk'
license 'Apache-2.0'
description 'Removes salt-minion from a Chef Node.'
long_description 'A cookbook for completing the migration from SaltStack to Chef by removing the SaltStack client (salt-minion) from a chef node.'
version '0.1.2'
chef_version '>= 12.1' if respond_to?(:chef_version)

issues_url 'https://github.com/jjm/chef-desalination/issues'
source_url 'https://github.com/jjm/chef-desalination'

supports 'ubuntu', '14.04'
supports 'ubuntu', '16.04'
supports 'centos'
