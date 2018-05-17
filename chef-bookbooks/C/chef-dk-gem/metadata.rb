name 'chef-dk-gem'
maintainer 'Franklin Hanson'
maintainer_email 'fhanson@gannett.com'
license 'Apache v2.0'
description 'Installs/Deletes chef-dk user gems'
version '1.0.0'

depends 'chef-dk'

%w(redhat centos scientific amazon fedora debian ubuntu).each do |os|
  supports os
end
