name 'glusterfs'
maintainer 'Sam4Mobile'
maintainer_email 'dps.team@s4m.io'
license 'Apache 2.0'
description 'Installs/Configures a GlusterFS cluster using systemd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://gitlab.com/s4m-chef-repositories/glusterfs'
issues_url 'https://gitlab.com/s4m-chef-repositories/glusterfs/issues'
version '1.1.0'

supports 'centos', '>= 7.1'

depends 'yum'
depends 'cluster-search'
