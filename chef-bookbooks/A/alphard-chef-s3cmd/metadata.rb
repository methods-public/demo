name                  'alphard-chef-s3cmd'
version               '1.2.1'
license               'Apache-2.0'
maintainer            'Hydra Technologies, Inc'
maintainer_email      'chef@hydra-technologies.net'
description           'Installs/Configures alphard-chef-s3cmd'
long_description      IO.read(File.join(File.dirname(__FILE__), 'README.md'))

depends               'poise-python', '>= 1.0.0'

%w(ubuntu debian centos fedora).each do |os|
  supports os
end

source_url            'https://github.com/hydra-technologies/alphard-chef-s3cmd' if respond_to?(:source_url)
issues_url            'https://github.com/hydra-technologies/alphard-chef-s3cmd/issues' if respond_to?(:issues_url)

chef_version          '>=12.5' if respond_to?(:chef_version)
