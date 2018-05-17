name             'fetch'
maintainer       'Jean-Francois Theroux'
maintainer_email 'me@failshell.io'
license          'Apache 2.0'
description      'Installs/Configures fetch'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '3.0.2'

%w(
  centos
  redhat
).each do |os|
  supports os
end
