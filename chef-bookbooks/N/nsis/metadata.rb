name             'nsis'
maintainer       'Ketan Padegaonkar'
maintainer_email 'ketanpadegaonkar@gmail.com'
license          'Apache v2.0'
description      'Installs/Configures NSIS'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.0'

depends 'yum'


%w{centos redhat}.each do |os|
  supports os
end
