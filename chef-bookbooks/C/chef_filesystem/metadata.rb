name 'chef_filesystem'
maintainer 'Vasiliy Tolstov'
maintainer_email 'v.tolstov@selfip.ru'
license 'MIT'
description 'Creates filesystems'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/vtolstov/cb-filesystem' if respond_to?(:source_url)
issues_url       'https://github.com/vtolstov/cb-filesystem/issues' if respond_to?(:issues_url)
version '0.0.7'

recipe 'filesystem',       'creates file systems'

%w(redhat centos ubuntu debian scientific exherbo archlinux).each do |os|
  supports os
end

%w(chef_blockdev).each do |dep|
  depends dep
end
