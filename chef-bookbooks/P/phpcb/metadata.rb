name 'phpcb'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures phpcb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.0'

%w(debian ubuntu redhat centos fedora scientific amazon).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/phpcb' if respond_to?(:source_url)
issues_url 'https://github.com/djoos-cookbooks/phpcb/issues' if respond_to?(:issues_url)

depends 'php'
depends 'composer'

recipe 'phpcb', 'Installs phpcb.'
recipe 'phpcb::composer', 'Installs phpcb using composer.'
recipe 'phpcb::phar', 'Installs phpcb using phar.'
