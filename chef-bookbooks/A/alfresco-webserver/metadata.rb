name             'alfresco-webserver'
maintainer       'Alfresco Tooling & Automation'
maintainer_email 'enzo.rivello@alfresco.com'
license          'Apache 2.0'
description      'Installs/Configures chef-alfresco-webserver'
long_description 'Installs and Configures the webserver part of the chef-alfresco stack'

issues_url       'https://github.com/Alfresco/chef-alfresco-webserver/issues'
source_url       'https://github.com/Alfresco/chef-alfresco-webserver'
version          '0.7.6'

chef_version '~> 12' if respond_to?(:chef_version)

supports 'centos', '>= 7.0'
supports 'redhat', '>= 7.0'

depends 'nginx', '~> 2.7.6'
depends 'netstat', '~> 0.1.0'
depends 'nginx-hardening', '~> 1.1.0'
