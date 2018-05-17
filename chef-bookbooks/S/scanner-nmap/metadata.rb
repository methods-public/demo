name             'scanner-nmap'
maintainer       'Risk I/O'
maintainer_email 'jro@risk.io'
license          'Apache 2.0'
description      'Install and control nmap'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{redhat centos scientific fedora debian ubuntu arch freebsd amazon}.each do |os|
  supports os
end

attribute "filename",
  :display_name => "Filename",
  :description => "File for scan output"

attribute "options",
  :display_name => "Options",
  :description => "Commandline options for nmap"

attribute "target",
  :display_name => "Target",
  :description => "Target(s) for scanning"

attribute "output",
  :display_name => "Output",
  :description => "Type of output report [normal, xml, script kiddie, greppable]"

