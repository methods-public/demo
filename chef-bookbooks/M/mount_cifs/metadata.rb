name             'mount_cifs'
maintainer       'Ryan Larson'
maintainer_email 'ryan.mango.larson@gmail.com'
license          'MIT'
description      'Installs requires packages to enable mounting over CIFS'
long_description description
version          '0.3.0'

depends "apt", '>= 0.0.0' 

supports 'ubuntu', '>= 10.04'
supports 'centos', '>= 5.10'
supports 'debian', '>= 7.4' 
supports 'fedora', '>= 18.0'
supports 'oracle', '>= 6.5'
