name             'php-windows'
maintainer       'Opscode, Inc.'
maintainer_email 'info@opscode.com'
license          'All rights reserved'
description      'Installs/configures PHP on Windows Azure'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.23"

%w{ windows }.each do |os|
  supports os
end

depends          "apache2-windows"
