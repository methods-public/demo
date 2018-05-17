name 'dhcp-wrapper'
maintainer 'Sam4Mobile'
maintainer_email 'dps.team@s4m.io'
license 'Apache 2.0'
description 'Wrapper around dhcp cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/s4m-chef-repositories/dhcp-wrapper'
issues_url 'https://gitlab.com/s4m-chef-repositories/dhcp-wrapper/issues'
version '1.3.0'

supports 'centos', '>= 7.1'

depends 'dhcp'
depends 'network_interfaces_v2'
