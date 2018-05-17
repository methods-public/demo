name             'chef-metal'
maintainer       'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license          'Apache 2.0'
description      'Provides a recipe for configuring the Chef Metal gem.'
long_description 'Provides a recipe for configuring the Chef Metal gem.'
version          '0.1.1'

%w(redhat centos).each do |name|
  supports name, '~> 7.0'
  supports name, '~> 6.4'
  supports name, '~> 5.8'
end

supports 'ubuntu', '= 14.04'
supports 'ubuntu', '= 12.04'
