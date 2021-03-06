name 'rhn'
maintainer 'Brian Flad'
maintainer_email 'bflad417@gmail.com'
license 'Apache 2.0'
description 'Registers node with RHN'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.3'
recipe 'rhn', 'RHN client configuration and system registration'
recipe 'rhn::actions', 'Configures RHN system actions on client'
recipe 'rhn::org_ca_cert', 'Installs organization CA certificate'
recipe 'rhn::org_gpg_key', 'Installs organization GPG key'
recipe 'rhn::register', 'Registers node with hosted RHN or Satellite'
recipe 'rhn::rhncfg', 'Configures RHN client configuration'
recipe 'rhn::rhnsd', 'Configures RHN sync daemon'
recipe 'rhn::up2date', 'Configures up2date'

supports 'redhat', '>= 5.0'
