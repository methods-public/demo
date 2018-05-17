name 'qpid'
maintainer 'Marius Karnauskas'
maintainer_email 'marius@karnauskas.lt'
license 'Apache 2.0'
description 'Installs/Configures qpid'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.3'

supports 'centos'
supports 'amazon'
supports 'redhat'

depends 'yum'
depends 'yum-epel'
