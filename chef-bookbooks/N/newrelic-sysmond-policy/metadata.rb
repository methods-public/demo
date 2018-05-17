name             'newrelic-sysmond-policy'
maintainer       'Issac Goldstand'
maintainer_email 'margol@beamartyr.net'
license          'Apache v2.0'
description      'Installs/Configures newrelic-sysmond-policy startup/shutdown scripts'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'
provides "service[newrelic-sysmond-policy]"
supports 'ubuntu'
supports 'centos'

depends 'nodejs'
recommends 'newrelic'
