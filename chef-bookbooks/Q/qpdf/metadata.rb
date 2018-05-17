# Encoding: utf-8
name             'qpdf'
maintainer       'Ross Timson'
maintainer_email 'ross@rosstimson.com'
license          'Apache 2.0'
description      'Installs qpdf from packages'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.0'

depends          'apt'
depends          'yum'

%w( debian ubuntu centos amazon ).each do |os|
  supports os
end

recipe           'qpdf::default', 'Installs qpdf from packages'
