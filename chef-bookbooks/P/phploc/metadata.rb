name 'phploc'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures phploc'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.1.0'

%w(debian ubuntu redhat centos fedora scientific amazon).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/phploc' if respond_to?(:source_url)
issues_url 'https://github.com/djoos-cookbooks/phploc/issues' if respond_to?(:issues_url)

depends 'php'
depends 'composer'

recipe 'phploc', 'Installs phploc.'
recipe 'phploc::composer', 'Installs phploc using composer.'
recipe 'phploc::phar', 'Installs phploc using phar.'
