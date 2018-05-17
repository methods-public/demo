name             'aerospike'
maintainer       'Vlad Gorodetsky'
maintainer_email 'v@gor.io'
license          'Apache 2.0'
description      'Installs/Configures aerospike'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
issues_url       'https://github.com/bai/cookbook-aerospike/issues'
source_url       'https://github.com/bai/cookbook-aerospike'

depends 'tar'

%w(debian ubuntu centos redhat).each do |os|
  supports os
end
