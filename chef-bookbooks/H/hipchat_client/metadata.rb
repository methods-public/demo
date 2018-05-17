name             'hipchat_client'
maintainer       'Erin Kolp'
maintainer_email 'ekolp@kickbackpoints.com'
license          'Apache 2.0'
description      'Installs Atlassian HipChat client'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.3.0'

%w{mac_os_x windows debian ubuntu centos rhel}.each do |os|
  supports os
end

depends 'apt', '>= 2.2.1'
depends 'yum', '>= 3.1.2'
