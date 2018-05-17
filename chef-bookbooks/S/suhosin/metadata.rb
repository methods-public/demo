name             'suhosin'
maintainer       'Yosuke INOUE'
maintainer_email 'inoue@fieldweb.co.jp'
license          'Apache 2.0'
description      'Installs/Configures suhosin'
version          '1.0.2'

%w{ centos redhat fedora }.each do |os|
  supports os
end

depends 'build-essential'
depends 'apache2'
depends 'php'
