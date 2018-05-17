# $ knife supermarket share berkshelf-api-server-ya "Applications"
name             'berkshelf-api-server-ya'
maintainer       'whitestar'
maintainer_email ''
license          'Apache 2.0'
description      'Installs/Configures berkshelf-api-server-ya'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.8'
source_url       'http://scm.osdn.jp/gitroot/metasearch/grid-chef-repo.git'
issues_url       'https://osdn.jp/projects/metasearch/ticket'

%w( debian ubuntu centos redhat ).each do |os|
  supports os
end

# local cookbooks

# external cookbooks
depends 'berkshelf-api-server', '= 2.1.1'
depends 'nginx', '= 2.7.6'
# ohai >= 4.0.0 throws nillclass on node['ohai']['plugin_path']
# https://github.com/priestjim/chef-openresty/issues/47
depends 'ohai', '< 4.0.0'
