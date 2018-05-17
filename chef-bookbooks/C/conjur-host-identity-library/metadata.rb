name              'conjur-host-identity-library'
maintainer        'Conjur, Inc.'
maintainer_email  'kgilpin@conjur.net, dbyrne@conjur.net'
license           'MIT'
description       'Library to obtain and install a Conjur host identity from host factory token'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.0.2'

%w(ubuntu centos).each do |platform|
  supports platform
end

depends 'conjur'