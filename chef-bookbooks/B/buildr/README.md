buildr Cookbook
===============
Installs Apache Buildr

Requirements
------------
Tested on Ubuntu 12.04. Should work on Debian, CentOS, Red Hat and Fedora

Attributes
------------
This cookbook depends on the java cookbook which, by default, installs OpenJDK.
This behavior can be changed with the ```node[:java][:install_flavor]``` 
attribute. Please refer to the java cookbook for more information.

Usage
-----
#### buildr::default
Installs buildr from Ruby Gems. It also installs Ruby and RubyGems if not 
already available on the system.

License and Authors
-------------------
Authors: Cyberfonica Dev Team
