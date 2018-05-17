name 'elastic_beats_repo'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures Elastic Beats APT/Yum Repository'
long_description 'Installs/Configures Elastic Beats APT/Yum Repository'
version '1.2.0'
source_url 'https://github.com/vkhatri/chef-elastic-beats-repo' if respond_to?(:source_url)
issues_url 'https://github.com/vkhatri/chef-elastic-beats-repo/issues' if respond_to?(:issues_url)
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'apt', '<= 6.1.4'
depends 'yum', '>= 5.0.1'

%w[debian ubuntu centos amazon redhat fedora].each do |os|
  supports os
end
