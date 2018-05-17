name 'collectd_ii'
maintainer 'Corey Hemminger'
maintainer_email 'hemminger@hotmail.com'
license 'Apache-2.0'
description 'Installs/Configures collectd_ii'
long_description 'Installs/Configures collectd_ii'
version '1.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/Stromweld/collectd_ii/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/Stromweld/collectd_ii'

%w{ amazon centos fedora redhat scientific ubuntu }.each do |os|
  supports os
end

depends 'build-essential'
depends 'yum-epel'
