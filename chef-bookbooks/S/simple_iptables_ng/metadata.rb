name             "simple_iptables_ng"
maintainer       "Dan Fruehauf"
maintainer_email "malkodan@gmail.com"
license          "GNU Public License 3.0"
description      "Simple wrapper cookbook for iptales-ng"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

recipe 'simple_iptables_ng::default', 'Configures iptables'

%w(
ubuntu
debian
redhat centos amazon suse scientific
fedora gentoo arch
).each do |os|
  supports os
end

depends 'iptables-ng'
