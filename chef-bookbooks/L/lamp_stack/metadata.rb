name             'lamp_stack'
maintainer       'Sujoy Majumder'
maintainer_email 'sujoy.majumder@sap.com'
license          'All rights reserved'
description      'Installs/Configures lamp_stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
%w{ centos redhat suse }.each do |os|
  supports os
end