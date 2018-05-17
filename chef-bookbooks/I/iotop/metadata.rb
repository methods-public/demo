name 'iotop'
maintainer 'Shalamus'
maintainer_email 'salamsahed@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures iotop'
long_description 'Installs/Configures iotop'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'git', '~> 8.0.0'

supports 'fedora'
supports 'ubuntu'
supports 'centos'
# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/shalamus/iotop/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/shalamus/iotop'
