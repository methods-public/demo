name             'cloudinsight-agent'
maintainer       'Cloudinsight'
maintainer_email 'support@oneapm.com'
description      'Installs/Configures cloudinsight-agent components'
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

recipe 'cloudinsight-agent::default', 'Default'
recipe 'cloudinsight-agent::cloudinsight-agent', 'Installs the cloudinsight-agent'
recipe 'cloudinsight-agent::repository', 'Installs the cloudinsight-agent package repository'
# Not completed.
#recipe 'cloudinsight-agent::cloudinsight-python', 'Installs the Python sdk for custom metrics'
#recipe 'cloudinsight-agent::cloudinsight-ruby', 'Installs the Ruby sdk for custom metrics'

# integration-specific
recipe 'cloudinsight-agent::cassandra', 'Installs and configures the Cassandra integration'
recipe 'cloudinsight-agent::couchdb', 'Installs and configures the CouchDB integration'
recipe 'cloudinsight-agent::postfix', 'Installs and configures the Postfix integration'
