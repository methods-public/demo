name 'logdna'
maintainer 'Samir Musali'
maintainer_email 'samir.musali@logdna.com'
description 'Installs/Configures LogDNA Agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
license 'MIT'

issues_url 'https://github.com/logdna/chef-logdna/issues'
source_url 'https://github.com/logdna/chef-logdna'

supports 'ubuntu'
supports 'centos'

depends 'yum'
depends 'apt'

recipe 'logdna::default', 'Main LogDNA Agent Recipe'
recipe 'logdna::configure', 'Configuring LogDNA Agent after installation'
recipe 'logdna::install_debian', 'Installing LogDNA Agent via APT'
recipe 'logdna::install_redhat', 'Installing LogDNA Agent via YUM'
recipe 'logdna::service_debian', 'Activating LogDNA Service on DEB-based systems'
recipe 'logdna::service_redhat', 'Activating LogDNA Service on RPM-based systems'
