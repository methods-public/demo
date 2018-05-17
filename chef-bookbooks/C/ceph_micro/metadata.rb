name             'ceph_micro'
maintainer       'Sofer Athlan-Guyot'
maintainer_email 'chem@sathlan.org'
license          'GPL 3.0'
description      'Installs ceph on one node with one osd, usefull for testing.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

supports 'ubuntu'
supports 'centos'
supports 'debian'

depends  'python'
depends  'yum-epel'
depends  'apt'
