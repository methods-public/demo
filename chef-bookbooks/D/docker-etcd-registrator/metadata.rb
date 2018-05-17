name             'docker-etcd-registrator'
maintainer       'Petr Belyaev'
maintainer_email 'upcfrost@gmail.com'
license          'All rights reserved'
description      'Installs/Configures docker-etcd-registrator'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
source_url       'https://github.com/upcFrost/chef_corosync_cookbook'
issues_url       'https://github.com/upcFrost/chef_corosync_cookbook/issues'

depends 'nodejs'
depends 'git'
depends 'poise-service'

supports 'centos'
supports 'redhat'
supports 'debian'
supports 'ubuntu'
