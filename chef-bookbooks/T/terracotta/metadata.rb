maintainer        "Elliot Kendall"
maintainer_email  "elliot.kendall@ucsf.edu"
license           "Apache 2.0"
description       "Installs terracotta"
version           "0.1.2"

recipe "terracotta", "Installs terracotta"

%w{ redhat centos fedora ubuntu debian }.each do |os|
  supports os
end
