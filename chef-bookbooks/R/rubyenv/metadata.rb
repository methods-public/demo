name "rubyenv"
maintainer "Dennis Vink"
maintainer_email "dennis.vink@sentia.com"
license "MIT"
description "Install one or more ruby versions with rbenv"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version "0.1.4"
supports 'ubuntu', '= 14.04'
supports 'centos', '= 6.6'

depends 'rbenv'
