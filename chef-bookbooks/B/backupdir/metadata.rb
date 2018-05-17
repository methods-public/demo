name             'backupdir'
maintainer       'dennyzhang'
maintainer_email 'denny.zhang001@gmail.com'
license          'All rights reserved'
description      'Backup directories by a crontab and do a remote copy'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.0'

supports 'centos'
supports 'debian'
supports 'fedora'
supports 'redhat'
supports 'suse'
supports 'ubuntu'

depends 'python', '=1.4.6'
