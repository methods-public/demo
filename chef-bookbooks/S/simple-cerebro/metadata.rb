name             'simple-cerebro'
maintainer       'One Model Inc.'
maintainer_email 'development@onemodel.co'
license          'Apache 2.0'
description      'Installs cerebro 0.3.1'
long_description 'Installs and configures cerebro 0.3.1, that is all.'
issues_url       'https://github.com/One-Model/simple-cerebro-cookbook/issues' if respond_to?(:issues_url)
source_url       'https://github.com/One-Model/simple-cerebro-cookbook' if respond_to?(:source_url)

version          '0.1.0'

depends 'java'
depends 'runit'
depends 'ark'

supports 'debian'
supports 'centos'
