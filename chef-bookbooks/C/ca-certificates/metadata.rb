name             'ca-certificates'
maintainer       'Jason Barnett'
maintainer_email 'J@sonBarnett.com'
license          'MIT'
description      'Installs/Configures ca-certificates'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
chef_version     '>= 11.8.0' if respond_to?(:chef_version)

%w( redhat centos amazon scientific oracle debian ).each do |os|
  supports os
end

source_url 'https://github.com/jasonwbarnett/ca-certificates-cookbook'
issues_url 'https://github.com/jasonwbarnett/ca-certificates-cookbook/issues'
