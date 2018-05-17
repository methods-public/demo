name "graphviz"
maintainer "Takuma J Miyake"
maintainer_email "j.e.miyake@gmail.com"
license "MIT"
description "Installs/Configures graphviz"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version "0.1.1"
recipe "graphviz", "Installs graphviz package"

%w{fedora centos rhel ubuntu debian}.each do |os|
  supports os
end
