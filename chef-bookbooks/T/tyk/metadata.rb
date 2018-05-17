name             'tyk'
maintainer       'Michal Taborsky'
maintainer_email 'michal.taborsky@mall.cz'
license          'Apache 2.0'
description      'Installs/Configures tyk'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'
source_url       'https://gitlab.com/nrh/tyk-cookbook'
issues_url       'https://gitlab.com/nrh/tyk-cookbook/issues'

%w( debian ubuntu centos redhat fedora scientific oracle ).each do |os|
  supports os
end

depends 'packagecloud', '~> 0.2.0'
depends 'redisio', '~> 2.4.2'
depends 'mongodb', '~> 0.16.2'
