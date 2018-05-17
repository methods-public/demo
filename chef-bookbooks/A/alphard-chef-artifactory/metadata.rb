name                  'alphard-chef-artifactory'
version               '1.3.1'
license               'Apache-2.0'
maintainer            'Hydra Technologies, Inc'
maintainer_email      'chef@hydra-technologies.net'
description           'Installs/Configures alphard-chef-artifactory'
long_description      IO.read(File.join(File.dirname(__FILE__), 'README.md'))

depends               'java', '>= 1.45.0'
depends               'apache2', '>= 3.2.2'

recipe                'alphard-chef-artifactory::default', 'Installs/Configures Artifactory'

%w(ubuntu debian centos fedora).each do |os|
  supports os
end

source_url            'https://github.com/hydra-technologies/alphard-chef-artifactory' if respond_to?(:source_url)
issues_url            'https://github.com/hydra-technologies/alphard-chef-artifactory/issues' if respond_to?(:issues_url)

chef_version          '>=12.5' if respond_to?(:chef_version)
