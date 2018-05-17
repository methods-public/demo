# $ knife supermarket share zookeeper-grid "Databases"
name             'zookeeper-grid'
maintainer       'whitestar'
maintainer_email ''
license          'Apache 2.0'
description      'Installs/Configures Apache Zookeeper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'
source_url       'http://scm.osdn.jp/gitroot/metasearch/grid-chef-repo.git'
issues_url       'https://osdn.jp/projects/metasearch/ticket'

%w( debian ubuntu centos redhat fedora ).each do |os|
  supports os
end

depends          'grid'
depends          'java'
