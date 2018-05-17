name              "lastrun_handler"
maintainer        "The Wharton School - The University of Pennsylvania"
maintainer_email  "bflad@wharton.upenn.edu"
license           "Apache 2.0"
description       "Installs and enables lastrun chef_handler."
version           "0.1.0"
recipe            "lastrun_handler", "Installs and enables lastrun chef_handler."

%w{ chef_handler }.each do |cb|
  depends cb
end

%w{ redhat ubuntu }.each do |os|
  supports os
end
