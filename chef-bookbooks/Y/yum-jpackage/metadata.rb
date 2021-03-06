# Encoding: utf-8
name             'yum-jpackage'
maintainer       'Mariani Lucas'
maintainer_email 'marianilucas@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures yum-jpackage'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue "0.1.0"

depends 'yum'

supports 'centos', '>= 6.0'
supports 'redhat', '>= 6.0'