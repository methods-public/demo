name             'buildr'
maintainer       'Cyberfonica Dev Team'
maintainer_email 'dev@cyberfonica.com'
license          'Apache 2.0'
description      'Installs/Configures buildr'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w{debian ubuntu centos redhat fedora amazon}.each do |os|
	supports os
end

depends 'build-essential'
depends 'java'
