name             'azurecli'
maintainer       'Alex Tu'
maintainer_email 'alex.lei.tu@gmail.com'
license          'All rights reserved'
description      'Installs/Configures azurecli'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'
source_url       'https://github.com/leitu/azure-cli-cookbooks'
issues_url       'https://github.com/leitu/azure-cli-cookbook/issues'

supports 'ubuntu'
supports 'centos'

depends 'poise-python'
depends 'nodejs'
