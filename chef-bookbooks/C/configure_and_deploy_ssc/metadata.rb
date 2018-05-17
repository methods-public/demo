name             'configure_and_deploy_ssc'
maintainer       ''
maintainer_email ''
license          'Apache 2.0'
description      'Configures and deploys the Fortify SSC Server WAR file.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
ver_path = File.join(File.dirname(__FILE__), 'version.txt')
version File.exist?(ver_path) ? IO.read(ver_path).chomp : '16.11'
supports 'redhat', '>= 7.0'
supports 'centos', '>= 7.0'

depends 'chef_handler'
depends 'zipfile', '>=0.1.0'
depends 'java'
depends 'tomcat', '~> 2.3.3'
depends 'mysql', '~> 6.1.3'
