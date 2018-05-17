name             'sickrage'
maintainer       'Jeremy Miller'
maintainer_email 'jmiller3346@gmail.com'
license          'All rights reserved'
description      'Installs/Configures sickrage'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
issues_url 'https://github.com/som3guy/sickrage/issues' if respond_to?(:issues_url)
source_url 'https://github.com/som3guy/sickrage.git' if respond_to?(:source_url)

supports 'centos', '>= 6.7'
supports 'fedora', '>= 6.7'
supports 'redhat', '>= 6.7'
supports 'scientific', '>= 6.7'

depends 'git', '~> 5.0.0'
depends 'build-essential', '~> 6.0.4'
depends 'yum-epel', '~> 1.0.0'
