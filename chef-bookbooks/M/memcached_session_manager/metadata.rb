name 'memcached_session_manager'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description "Tomcat high-availability clusters with memcached using Martin Grotzke's memcached-session-manager"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

supports 'centos'
supports 'redhat'
supports 'ubuntu'

depends 'maven', '~> 1.3'
