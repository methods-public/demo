maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
name             "oozie"
license          "Apache v2.0"
description      "Installs/Configures an Oozie Server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"
source_url       "https://github.com/hopshadoop/oozie-chef"

%w{ ubuntu debian centos }.each do |os|
  supports os
end

depends 'java'

recipe "oozie::default", "Installs and configures Oozie Server"

attribute "oozie/user",
:description => "User to run Oozie server as",
:type => "string"


