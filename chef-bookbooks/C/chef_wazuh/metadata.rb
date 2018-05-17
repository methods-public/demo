name 'chef_wazuh'
maintainer 'Alex Markessinis'
maintainer_email 'markea125@gmail.com'
license 'MIT'
description 'Installs and configures Wazuh on Linux.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.6'
chef_version '>= 12.1' if respond_to?(:chef_version)
supports 'ubuntu', '>= 16.04'
supports 'debian', '>= 7.0'
supports 'redhat', '>= 7.0'
supports 'centos', '>= 7.0'
issues_url 'https://github.com/MelonSmasher/chef_wazuh/issues' if respond_to?(:issues_url)
source_url 'https://github.com/MelonSmasher/chef_wazuh' if respond_to?(:source_url)
