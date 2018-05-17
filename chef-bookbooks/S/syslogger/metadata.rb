name             'syslogger'
maintainer       'Risk I/O'
maintainer_email 'jro@risk.io'
license          'Apache 2.0'
description      'sysloger LWRP for logging to syslog'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{redhat centos scientific fedora debian ubuntu arch freebsd amazon}.each do |os|
  supports os
end
