name             "pngquant"
description      "Installs pngquant"
version          "0.1.1"
maintainer       "Zoocha"
license          "Apache 2.0"

recipe "pngquant", "Installs pngquant"

%w{centos rhel ubuntu debian}.each do |os|
  supports os
end

source_url 'https://github.com/Alexj12/pngquant-chef'
issues_url 'https://github.com/Alexj12/pngquant-chef/issues'