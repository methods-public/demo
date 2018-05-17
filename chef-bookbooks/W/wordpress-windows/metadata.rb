name		"wordpress-windows"
maintainer       "Opscode"
maintainer_email "info@opscode.com"
license          "All rights reserved"
description      "Installs/Configures Wordpress on Windows Azure"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.36"

%w{ windows }.each do |os|
  supports os
end

depends          "windows"
depends          "mysql"
depends          "apache2-windows"
depends          "php-windows"
depends          "openssl"
