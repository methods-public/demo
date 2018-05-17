name 'chef_bird'
maintainer 'Vasiliy Tolstov'
maintainer_email 'v.tolstov@selfip.ru'
license 'MIT'
description 'Installs/configures bird'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/vtolstov/chef_bird' if respond_to?(:source_url)
issues_url       'https://github.com/vtolstov/chef_bird/issues' if respond_to?(:issues_url)
version '0.0.4'

%w(debian ubuntu centos fedora arch).each do |os|
  supports os
end

depends 'ohai'
