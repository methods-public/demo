# Encoding: utf-8
name              'dtach'
maintainer        'Ross Timson'
maintainer_email  'ross@rosstimson.com'
license           'Apache 2.0'
description       'Installs dtach'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.0.0'

%w{ debian ubuntu centos amazon }.each do |os|
  supports os
end

attribute 'dtach/install_path',
  display_name: 'Install path',
  description: 'Path to install executable into',
  default: '/usr/local/bin'
