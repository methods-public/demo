name 'phpdcd'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures phpdcd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.0'

%w(debian ubuntu redhat centos fedora scientific amazon).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/phpdcd' if respond_to?(:source_url)
issues_url 'https://github.com/djoos-cookbooks/phpdcd/issues' if respond_to?(:issues_url)

depends 'php'
depends 'git'
depends 'composer'

recipe 'phpdcd', 'Installs phpdcd.'
recipe 'phpdcd::composer', 'Installs phpdcd using composer.'
recipe 'phpdcd::phar', 'Installs phpdcd using phar.'
