# $ knife supermarket share kubernetes-grid "Operating Systems & Virtualization"
name             'kubernetes-grid'
maintainer       'whitestar'
maintainer_email ''
license          'Apache 2.0'
description      'Installs/Configures Kubernetes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

source_url       'http://scm.osdn.jp/gitroot/metasearch/grid-chef-repo.git'
issues_url       'https://osdn.jp/projects/metasearch/ticket'

%w( centos redhat ).each do |os|
  supports os, '>= 7.2'
end
supports 'ubuntu', '>= 16.04'

# external cookbooks
depends 'docker-grid', '>= 0.2.8'
