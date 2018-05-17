name             'oneapm-ci-agent'
maintainer       'OneAPM'
maintainer_email 'support@oneapm.com'
description      'Installs/Configures oneapm-ci-agent components'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w(
  amazon
  centos
  debian
  fedora
  redhat
  scientific
  ubuntu
).each do |os|
  supports os
end

depends          'apt' # recommend '>= 2.1.0'.
depends          'chef_handler', '~> 1.1.0'
depends          'yum'

suggests         'sudo'

recipe 'oneapm-ci-agent::default', 'Default'
recipe 'oneapm-ci-agent::oneapm-ci-agent', 'Installs the oneapm-ci-agent'
recipe 'oneapm-ci-agent::repository', 'Installs the oneapm-ci-agent package repository'
# Not completed.
#recipe 'oneapm-ci-agent::onestatsd-python', 'Installs the Python onestatsd package for custom metrics'
#recipe 'oneapm-ci-agent::onestatsd-ruby', 'Installs the Ruby onestatsd package for custom metrics'

# integration-specific
recipe 'oneapm-ci-agent::cassandra', 'Installs and configures the Cassandra integration'
recipe 'oneapm-ci-agent::couchdb', 'Installs and configures the CouchDB integration'
recipe 'oneapm-ci-agent::postfix', 'Installs and configures the Postfix integration'
