name                  'alphard-chef-loggly'
version               '3.2.1'
license               'Apache-2.0'
maintainer            'Hydra Technologies, Inc'
maintainer_email      'chef@hydra-technologies.net'
description           'Installs/Configures alphard-chef-loggly'
long_description      IO.read(File.join(File.dirname(__FILE__), 'README.md'))

depends               'rsyslog', '>= 4.0.0'

recipe                'alphard-chef-loggly::default', 'Installs/Configures alphard-chef-loggly'

%w(ubuntu centos).each do |os|
  supports os
end

source_url            'https://github.com/hydra-technologies/alphard-chef-loggly' if respond_to?(:source_url)
issues_url            'https://github.com/hydra-technologies/alphard-chef-loggly/issues' if respond_to?(:issues_url)

chef_version          '>=12.5' if respond_to?(:chef_version)
