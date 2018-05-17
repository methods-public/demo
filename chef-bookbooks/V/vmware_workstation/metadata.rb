name             'vmware_workstation'
maintainer       'Daptiv Solutions, LLC'
maintainer_email 'dl_teamengineering@daptiv.com'
license          'All rights reserved'
description      'Installs and configures VMware Workstation 10'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
supports         'ubuntu'
supports         'windows'

depends          'windows', '~> 1.31.0'
