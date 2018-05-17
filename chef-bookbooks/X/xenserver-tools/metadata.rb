name             'xenserver-tools'
maintainer       'James Le Cuirot'
maintainer_email 'james.le-cuirot@yakara.com'
license          'Apache 2.0'
description      'Installs the XenServer Tools'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

issues_url 'https://github.com/yakara-ltd/chef-xenserver-tools/issues'
source_url 'https://github.com/yakara-ltd/chef-xenserver-tools'

depends 'systemd'

supports 'centos'
supports 'debian'
