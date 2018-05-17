name             'stackdriver'
maintainer       'David Laube'
maintainer_email 'dave@dlaube.com'
license          'MIT'
description      'Installs/Configures stackdriver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ redhat centos fedora }.each do |os|
supports os
end

recipe "stackdriver", "Adds the Stackdriver repository, installs & configures the Stackdriver agent package."
recipe "stackdriver::repo", "Adds the Stackdriver repository."

