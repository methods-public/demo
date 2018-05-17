name             'spac'
maintainer       'Sander Botman'
maintainer_email 'sander.botman@gmail.com'
license          'Apache License 2.0'
description      'Installs/Configures the spac service'
source_url       'https://github.com/sbotman/spac_cookbook' if respond_to?(:source_url)
issues_url       'https://github.com/sbotman/spac_cookbook/issues' if respond_to?(:issues_url)
chef_version     '>= 12.5' if respond_to?(:chef_version)
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports         'linux'
supports         'windows'
