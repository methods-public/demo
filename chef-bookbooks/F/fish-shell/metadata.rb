name             'fish-shell'
maintainer       'David Aronsohn'
maintainer_email 'WagThatTail@Me.com'
license          'BSD'
description      'Installs/Configures fish-shell'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.1'

%w( mac_os_x centos freebsd amazon arch openbsd ).each do |os|
  supports os
end

depends 'build-essential'
depends 'yum'
depends 'ark'
