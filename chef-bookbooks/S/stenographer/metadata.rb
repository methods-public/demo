name             'stenographer'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'Apache 2.0'
description      'Installs/Configures stenographer'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


%w(centos redhat).each do |os|
  supports os
end


depends 'yum'
depends 'yum-epel'
