name 'kubernetes-stack'
maintainer 'Teracy Corporation'
maintainer_email 'hq@teracy.com'
license 'MIT'
description 'Installs/Configures kubernetes'
long_description 'Installs/Configures kubernetes stack'
version '0.1.1'


# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/teracyhq-incubator/kubernetes-stack-cookbook/issues' if respond_to?(:issues_url)

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/teracyhq-incubator/kubernetes-stack-cookbook' if respond_to?(:source_url)

chef_version '>= 12.5' if respond_to?(:chef_version)

supports 'ubuntu'
supports 'centos'
