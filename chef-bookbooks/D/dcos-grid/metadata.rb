# $ knife supermarket share dcos-grid "Operating Systems & Virtualization"
name             'dcos-grid'
maintainer       'whitestar'
maintainer_email ''
license          'Apache 2.0'
description      'Installs/Configures DC/OS Cluster Node.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.5.4'
source_url       'http://scm.osdn.jp/gitroot/metasearch/grid-chef-repo.git'
issues_url       'https://osdn.jp/projects/metasearch/ticket'

%w( centos redhat ).each do |os|
  supports os, '>= 7.2'
end
# Experimental
supports 'ubuntu', '>= 16.04'

# external cookbooks
depends 'docker-grid', '>= 0.3.1'
