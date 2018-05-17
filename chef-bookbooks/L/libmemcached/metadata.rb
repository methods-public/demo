name              "libmemcached"
maintainer        "Frederico Araujo (originally by Tomaz Muraus)"
maintainer_email  "fred.the.master@gmail.com (tomaz+cookbooks@tomaz.me)"
license           "Apache 2.0"
description       "Install/Configure libmemcached"
version           "0.1.0"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))

supports "ubuntu"
supports "debian"
supports "centos"
supports "amazon"
supports "scientific"
supports "fedora"
supports "redhat"

depends "build-essential"
