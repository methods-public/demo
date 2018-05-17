name             'cis_centos6'
maintainer       'Huddle'
maintainer_email 'help@huddle.com'
license          'MIT'
description      'This cookbook implements server hardening as specified by the CIS Benchmark for CentOS 6, version 1.1.0.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.5.2'

source_url       'https://github.com/Huddle/cis_centos6'
issues_url       'https://github.com/Huddle/cis_centos6/issues'

supports         'centos', '~> 6.7'
