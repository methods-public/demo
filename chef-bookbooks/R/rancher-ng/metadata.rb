name 'rancher-ng'
maintainer 'Alexander Merkulov'
maintainer_email 'sasha@merqlove.ru'
license 'Apache 2.0'
description 'Installs/Configures Rancher'
long_description 'Installs and configures Rancher service'
version '0.1.33'
chef_version '>= 12.5' if respond_to?(:chef_version)

depends 'docker', '~> 2.0'

supports 'ubuntu', '>= 14.04'
supports 'centos', '>= 7.0'

issues_url 'https://github.com/merqlove-cookbooks/chef-rancher-ng/issues' if respond_to?(:issues_url)
source_url 'https://github.com/merqlove-cookbooks/chef-rancher-ng' if respond_to?(:source_url)
