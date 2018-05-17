name 'kubectl'
maintainer 'Dave Newman'
maintainer_email 'newman.de+kubectl@gmail.com'
license 'MIT'
description 'Installs/Configures kubectl'
long_description 'Installs/Configures kubectl'
version '0.1.2'
chef_version '>= 12.1' if respond_to?(:chef_version)
supports 'windows'
supports 'mac_os_x'
supports 'ubuntu', '>= 16.04'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/davidnewman/chef_kubectl/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/davidnewman/chef_kubectl'
