name 'pdepend'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures pdepend'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.2.0'

%w(debian ubuntu redhat centos fedora scientific amazon).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/pdepend' if respond_to?(:source_url)
issues_url 'https://github.com/djoos-cookbooks/pdepend/issues' if respond_to?(:issues_url)

depends 'php'
depends 'composer'

recipe 'pdepend', 'Installs pdepend.'
recipe 'pdepend::composer', 'Installs pdepend using composer.'
recipe 'pdepend::pear', 'Installs pdepend using pear.'
recipe 'pdepend::phar', 'Installs pdepend using phar.'
