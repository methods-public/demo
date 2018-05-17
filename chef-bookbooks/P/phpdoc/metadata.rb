name 'phpdoc'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures phpdoc'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.0'

%w(debian ubuntu redhat centos fedora scientific amazon).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/phpdoc' if respond_to?(:source_url)
issues_url 'https://github.com/djoos-cookbooks/phpdoc/issues' if respond_to?(:issues_url)

depends 'php'
depends 'composer'

recipe 'phpdoc', 'Installs phpdoc.'
recipe 'phpdoc::composer', 'Installs phpdoc using composer.'
recipe 'phpdoc::pear', 'Installs phpdoc using pear.'
recipe 'phpdoc::phar', 'Installs phpdoc using phar.'
