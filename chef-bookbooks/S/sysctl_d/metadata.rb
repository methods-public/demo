name             'sysctl_d'
maintainer       'Lev Popov'
maintainer_email 'leo@nabam.net'
license          'BSD'
description      'Configures sysctl.d files'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.4'

%w(redhat ubuntu debian centos).each do |os|
    supports os
end

depends          'sysctl'
