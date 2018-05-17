name             'schannel'
maintainer       'pde159'
maintainer_email 'pdeprey@gmail.com'
license          'Apache-2.0'
description      'Chef cookbook to manage your windows security channels.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.1'
supports         'windows'
source_url       'https://github.com/pde159/schannel'
issues_url       'https://github.com/pde159/schannel/issues'
chef_version     '>= 12.6' if respond_to?(:chef_version)
