name             'os_floating_lo'
maintainer       'John Bartko'
maintainer_email 'jbartko@gmail.com'
license          'MIT'
description      'Add system-level visibility into OpenStack floating IPs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/jbartko/chef-os_floating_lo' if respond_to?(:source_url)
issues_url       'https://github.com/jbartko/chef-os_floating_lo/issues' if respond_to?(:issues_url)
version          '0.1.2'

attribute 'os_floating_lo/device',
  :default => 'lo:0',
  :description => 'Device on which to apply the floating IP.',
  :display_name => 'Floating Loopback Device',
  :type => 'string'

attribute 'os_floating_lo/mask',
  :default => '255.255.255.255',
  :description => 'Netmask for the floating IP. Do not change unless absolutely required.',
  :display_name => 'Floating Loopback Netmask',
  :type => 'string'

depends 'ohai'

%w{centos debian fedora ubuntu}.each do |os|
  supports os
end
