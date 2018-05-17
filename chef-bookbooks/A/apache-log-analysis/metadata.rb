name             'apache-log-analysis'
maintainer       'dennyzhang'
maintainer_email 'denny.zhang001@gmail.com'
license          'All rights reserved'
description      'Analysis apache logs by logstash, elasticsearch and kibana'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.5'

supports 'centos'
supports 'debian'
supports 'fedora'
supports 'redhat'
supports 'ubuntu'

depends 'java'
depends 'logstash'
depends 'elasticsearch'
depends 'chamber-kibana'
