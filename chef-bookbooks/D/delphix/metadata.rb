name 'delphix'
maintainer 'Derek Smart'
maintainer_email 'derek.smart@delphix.com'
license 'Apache-2.0'
description 'Installs/Configures target hosts for use by the Delphix platform'
long_description 'Installs/Configures target hosts for use by the Delphix platform'
version '0.1.2'
chef_version '>= 12.14' if respond_to?(:chef_version)
depends 'ssh_authorized_keys', '~> 0.4.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/delphix/chef/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/delphix/chef'

supports 'ubuntu'
supports 'debian'
supports 'redhat'
supports 'centos'
