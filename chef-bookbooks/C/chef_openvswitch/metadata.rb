name 'chef_openvswitch'
maintainer 'Vasiliy Tolstov'
maintainer_email 'v.tolstov@selfip.ru'
license 'MIT'
description 'Installs/configures openvswitch'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/vtolstov/chef_openvswitch' if respond_to?(:source_url)
issues_url       'https://github.com/vtolstov/chef_openvswitch/issues' if respond_to?(:issues_url)
version '0.0.1'

%w(debian ubuntu exherbo gentoo fedora centos).each do |os|
  supports os
end
