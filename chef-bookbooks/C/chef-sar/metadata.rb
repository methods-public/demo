name             "chef-sar"
maintainer       "Philip Hutchins"
maintainer_email "flipture@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures sar"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ ubuntu debian redhat centos scientific amazon fedora }.each do |os|
  supports os
end

%w{ yum apt }.each do |ckbk|
  recommends ckbk
end
