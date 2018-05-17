name 'phpmd'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures phpmd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

%w(debian ubuntu redhat centos fedora scientific amazon).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/phpmd' if respond_to?(:source_url)
issues_url 'https://github.com/djoos-cookbooks/phpmd/issues' if respond_to?(:issues_url)

depends 'php'
depends 'composer'
depends 'pdepend'

recipe 'phpmd', 'Installs phpmd.'
recipe 'phpmd::composer', 'Installs phpmd using composer.'
recipe 'phpmd::pear', 'Installs phpmd using pear.'
recipe 'phpmd::phar', 'Installs phpmd using phar.'
