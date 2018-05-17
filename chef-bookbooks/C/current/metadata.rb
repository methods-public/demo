name 'current'
maintainer 'David Radcliffe'
maintainer_email 'radcliffe.david@gmail.com'
license 'MIT'
description 'Installs/Configures current'
long_description 'Installs current cli and configures current send services'
version '0.4.1'

recipe 'current', 'NOOP'
recipe 'current::install', 'Installs current package'

# supports 'amazon'
# supports 'centos'
supports 'debian'
# supports 'redhat'
# supports 'scientific'
supports 'ubuntu'

depends 'runit'
