name 'chef_sheepdog'
maintainer 'Vasiliy Tolstov'
maintainer_email 'v.tolstov@selfip.ru'
license 'MIT'
description 'Installs/Configures sheepdog'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/vtolstov/chef_sheepdog' if respond_to?(:source_url)
issues_url       'https://github.com/vtolstov/chef_sheepdog/issues' if respond_to?(:issues_url)
version '0.0.2'

%w(chef_filesystem pacemaker).each do |dep|
  depends dep
end

%w(exherbo debian ubuntu archlinux suse centos fedora).each do |os|
  supports os
end
