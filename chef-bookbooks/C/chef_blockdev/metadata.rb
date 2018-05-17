name 'chef_blockdev'
maintainer 'Vasiliy Tolstov'
maintainer_email 'v.tolstov@selfip.ru'
license 'MIT'
description 'Operates on block devices'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/vtolstov/chef_blockdev' if respond_to?(:source_url)
issues_url       'https://github.com/vtolstov/chef_blockdev/issues' if respond_to?(:issues_url)
version '0.0.2'

recipe 'blockdev',       'manages block devices'

%w(redhat centos ubuntu debian scientific exherbo archlinux).each do |os|
  supports os
end
