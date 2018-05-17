name             'linux-basic'
maintainer       'DennyZhang'
maintainer_email 'denny.zhang001@gmail.com'
license          'All rights reserved'
description      'Basic DevOps for single machine'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.3.1'

supports         'ubuntu',           '>= 12.04'
supports         'debian',           '>= 6.0'
supports         'centos',           '>= 6.5'

depends          'ntp'
depends          'timezone-ii'
depends          'openssh'
depends          'selinux'

depends          'systempatch',      '>=1.1.2'

depends 'apt'
depends 'yum-epel'
