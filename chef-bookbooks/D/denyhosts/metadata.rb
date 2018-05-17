name             'denyhosts'
maintainer       'North County Tech Center, LLC'
maintainer_email 'kkeane@4nettech.com'
license          'GNU Public License 3.0'
description      'Installs and configures DenyHosts'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w{ centos }.each do |os|
  supports os
end

depends "yum-epel"

