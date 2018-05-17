name 'nginx-wrapper'
maintainer 'Sam4Mobile'
maintainer_email 'dps.team@s4m.io'
license 'Apache 2.0'
description 'Install and configure nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/s4m-chef-repositories/nginx-wrapper'
issues_url 'https://gitlab.com/s4m-chef-repositories/nginx-wrapper/issues'
version '1.0.0'

supports 'centos', '>= 7.1'

depends 'chef_nginx'
depends 'nginx_conf'
depends 'certificate'
