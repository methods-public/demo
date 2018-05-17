name 'the_silver_searcher'
maintainer 'Mark Cornick'
maintainer_email 'mark@markcornick.com'
license 'MIT'
description 'Installs/Configures The Silver Searcher'
depends 'build-essential'
version '1.4.3'

%w(debian ubuntu redhat centos fedora).each do |platform|
  supports platform
end
