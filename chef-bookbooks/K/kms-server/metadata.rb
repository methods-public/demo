name             'kms-server'
maintainer       'Annih'
maintainer_email 'b.courtois@criteo.com'
license          'Apache-2.0'
description      'Installs/Configures kms-server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.0'
supports         'windows', '>= 6.3'
depends          'windows', '>= 1.36.1'

chef_version '>= 12.6' if respond_to?(:chef_version)
source_url 'https://github.com/annih/kms-server' if respond_to? :source_url
issues_url 'https://github.com/annih/kms-server/issues' if respond_to? :issues_url
