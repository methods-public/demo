name 'chef_dnsmasq'
maintainer 'Vasiliy Tolstov'
maintainer_email 'v.tolstov@selfip.ru'
license 'MIT'
description 'Installs/configures dnsmasq'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/vtolstov/chef_dnsmasq' if respond_to?(:source_url)
issues_url       'https://github.com/vtolstov/chef_dnsmasq/issues' if respond_to?(:issues_url)
version '0.0.1'

%w(hostsfile).each do |dep|
  depends dep
end

%w(debian ubuntu centos fedora rhel).each do |os|
  supports os
end
