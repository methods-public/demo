name             'jolokia-jvm-agent'
maintainer       'hirocaster'
maintainer_email 'hohtsuka@gmail.com'
license          'MIT'
description      'Installs/Configures jolokia-jvm-agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
source_url       'https://github.com/hirocaster/chef-jolokia-jvm-agent'
issues_url       'https://github.com/hirocaster/chef-jolokia-jvm-agent/issues'

%w{centos ubuntu}.each do |os|
  supports os
end
