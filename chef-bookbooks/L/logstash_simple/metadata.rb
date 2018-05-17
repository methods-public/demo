name             'logstash_simple'
maintainer       'Thomas Riley'
maintainer_email ''
license          'Apache 2.0'
description      'Installs/Configures logstash'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.4'

issues_url       'https://github.com/thomasriley/logstash_simple/issues' if respond_to?(:issues_url)
source_url       'https://github.com/thomasriley/logstash_simple' if respond_to?(:source_url)

supports 'centos'

#depends 'java'

