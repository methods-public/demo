name             'oracle_client'
maintainer       'own'
maintainer_email 'suvadipmandal@gmail.com'
license          'Apache-2.0'
description      'Installs/Configures oracle_client'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'windows'
chef_version '>= 12.5.1' if respond_to?(:chef_version)
source_url "https://github.com/suvadip30/chef-fluency/"
issues_url "https://github.com/suvadip30/chef-fluency/issues"

