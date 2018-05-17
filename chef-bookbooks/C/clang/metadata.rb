name             'clang'
maintainer       'John Bellone (<jbellone@bloomberg.net>)'
maintainer_email 'jbellone@bloomberg.net'
license          'Apache 2.0'
description      'Installs clang from package or source.'
long_description 'Installs clang from package or source.'
version          '0.1.1'

%w(centos redhat).each do |name|
  supports name, '~> 7.0'
  supports name, '~> 6.4'
  supports name, '~> 5.8'
end

supports 'ubuntu', '= 14.04'
supports 'ubuntu', '= 12.04'

depends 'ark'
