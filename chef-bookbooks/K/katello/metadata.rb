name             'katello'
maintainer       'Chef Software, Inc.'
maintainer_email 'jdunn@getchef.com'
license          'Apache 2.0'
description      'Installs and configures Katello'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w(centos redhat fedora).each do |p|
  supports p
end

%w(java openssl selinux yum yum-epel).each do |d|
  depends d
end
