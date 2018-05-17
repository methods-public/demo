name                  'alphard-chef-deploy'
version               '1.3.5'
license               'Apache-2.0'
maintainer            'Hydra Technologies, Inc'
maintainer_email      'chef@hydra-technologies.net'
description           'Installs/Configures alphard jvm and web packages'
long_description      IO.read(File.join(File.dirname(__FILE__), 'README.md'))

depends               'java', '>= 0.0.0'
depends               'poise-service', '>= 0.0.0'
depends               'poise-monit', '>= 0.0.0'
depends               'alphard-chef-awscli', '>= 1.2.1'
depends               'alphard-chef-s3cmd', '>= 1.2.1'

%w(ubuntu debian centos fedora).each do |os|
  supports os
end

source_url            'https://github.com/hydra-technologies/alphard-chef-deploy' if respond_to?(:source_url)
issues_url            'https://github.com/hydra-technologies/alphard-chef-deploy/issues' if respond_to?(:issues_url)

chef_version          '>=12.5' if respond_to?(:chef_version)
