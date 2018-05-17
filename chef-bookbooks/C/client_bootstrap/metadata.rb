name 'client_bootstrap'
maintainer 'Frederik Gutzeit'
license 'all_rights'
description 'Bootstrap new Chef-Nodes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.5'

%w(
  centos
  redhat
  fedora
  windows
).each do |os|
  supports os
end

source_url 'https://github.com/Rikzg/client_bootstrap'
issues_url 'https://github.com/Rikzg/client_bootstrap/issues'
chef_version '>= 12.1'

