name             'nscp'
maintainer       'Azat Khadiev'
maintainer_email 'anuriq@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures NSClient++ for Windows operating system'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
source_url       'https://github.com/anuriq/chef-nscp'
issues_url       'https://github.com/anuriq/chef-nscp/issues'

supports         'windows'

depends          'chocolatey', '~> 1.0'
