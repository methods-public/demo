name 'dkron'
maintainer 'Michal Taborsky'
maintainer_email 'michal.taborsky@mall.cz'
license 'Apache 2.0'
description 'Installs and configures dkron server or agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.4'
source_url 'https://gitlab.com/mallgroup/dkron-cookbook'
issues_url 'https://gitlab.com/mallgroup/dkron-cookbook/issues'

depends 'ark'
depends 'runit'

supports 'redhat'
supports 'centos'
supports 'amazon'
supports 'scientific'
supports 'debian'
supports 'ubuntu'
