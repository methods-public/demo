name              'alphard-chef-sbt'
maintainer        'Hydra Technologies, Inc'
maintainer_email  'chef@hydra-technologies.net'
license           'apachev2'
description       'Installs/Configures SBT'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.2.2'

recipe            'alphard-chef-sbt::default', 'Installs/Configures SBT'

depends           'java', '>= 1.40.0'

%w(ubuntu debian centos fedora).each do |os|
  supports os
end

issues_url        'https://github.com/hydra-technologies/alphard-chef-sbt/issues' if respond_to?(:issues_url)
source_url        'https://github.com/hydra-technologies/alphard-chef-sbt' if respond_to?(:source_url)

chef_version      '>=12.0' if respond_to?(:chef_version)
