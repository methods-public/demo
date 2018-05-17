name 'example_library'
maintainer 'Kevin Dickerson'
maintainer_email 'kevin.dickerson@loom.technology'
license 'Apache 2.0'
description 'Provider cookbook that defines an example Chef library ' \
            'cookbook. Integration tests in InSpec.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.2'

supports 'centos', '>= 5.11'
supports 'debian', '>= 7.9'
supports 'fedora', '>= 22.0'
supports 'ubuntu', '>= 12.04'

source_url 'https://github.com/loom-cookbooks/example_library'
issues_url 'https://github.com/loom-cookbooks/example_library/issues'
