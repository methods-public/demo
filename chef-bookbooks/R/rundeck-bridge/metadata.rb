name             'rundeck-bridge'
maintainer       'Robert Veznaver'
maintainer_email 'r.veznaver@criteo.com'
issues_url       'https://github.com/criteo-cookbooks/rundeck-bridge/issues' if defined?(source_url)
source_url       'https://github.com/criteo-cookbooks/rundeck-bridge' if defined?(issues_url)
license          'Apache License 2.0'
description      'Installs chef-rundeck bridge and configure as needed'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.1.3'
supports         'centos'

depends          'chef-client'
depends          'poise-service'

suggests         'rundeck-server'
suggests         'rundeck-node'
