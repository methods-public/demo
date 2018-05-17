name 'phpcpd'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures phpcpd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.0'

%w(debian ubuntu redhat centos fedora scientific amazon).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/phpcpd' if respond_to?(:source_url)
issues_url 'https://github.com/djoos-cookbooks/phpcpd/issues' if respond_to?(:issues_url)

depends 'php'
depends 'git'
depends 'composer'

recipe 'phpcpd', 'Installs phpcpd.'
recipe 'phpcpd::composer', 'Installs phpcpd using composer.'
recipe 'phpcpd::phar', 'Installs phpcpd using phar.'
