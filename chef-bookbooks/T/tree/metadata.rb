name             'tree'
maintainer       'Adib Saad'
maintainer_email 'adib.saad@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures tree'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w(debian ubuntu arch redhat centos fedora scientific oracle amazon zlinux).each do |os|
  supports os
end

source_url 'https://github.com/adibsaad/tree' if respond_to?(:source_url)
issues_url 'https://github.com/adibsaad/tree/issues' if respond_to?(:issues_url)
